import collections
from contextlib import contextmanager
from glob import glob
import json
import platform
from subprocess import check_output, STDOUT
from tempfile import NamedTemporaryFile
import sys
import os


def is_str(s):
    return isinstance(s, str)

def getpath(source):
    if '@' in source:
        # SSH
        chunks = source.split(':')[-1].split('/')
        site = source.split('@')[-1].split(':')[0]
        user = chunks[0]
        repo = chunks[-1].replace('.git', '')
    else:
        url = source.split('://')[-1]
        chunks = url.split('/')
        site, user, repo = chunks[:3]
    return site, user, repo

@contextmanager
def chdir(path):
    current = os.getcwd()
    os.chdir(path)
    yield
    os.chdir(current)

def mkdir(path):
    try:
        os.makedirs(path)
    except OSError as err:
        if err.errno == 17:
            # ERREXISTS
            pass
        else:
            raise


def runcmd(cmd):
    out = check_output(cmd, shell=True, stderr=STDOUT)
    return out.strip().decode(errors='ignore')


def install_sources(sources):
    # TODO: install from git if necessary under ~/.config/shell/SOURCE/NAME/repo
    # TODO: handle the rest as normal
    mkdir(os.path.expanduser('~/.config/zsh/repos'))
    for source, config in sources.items():
        if isinstance(config, str):
            config = {"destination": config}
        if isinstance(config, dict):
            site, user, repo = getpath(source)
            repo_dir = os.path.expanduser(config.get('destination', "~/.config/zsh/repos/{}/{}-{}".format(site, user, repo)))
            if not os.path.isdir(repo_dir):
                print("Cloning {}".format(source))
                runcmd("git clone {} {}".format(source, repo_dir))
            else:
                print("Updating {}".format(source))
                with chdir(repo_dir):
                    runcmd("git pull origin master")
            # Add the repo dir
            symlinks = {'{}/{}'.format(repo_dir, k): v for k, v in config.get('symlinks', {}).items()}
            install_symlinks(symlinks)
            post_install(config)
        else:
            raise TypeError("Invalid source block of type '{}'".format(type(config)))


def install_symlinks(config):
    for src, dst in config.items():
        # TODO: install
        if not (src.startswith('/') or src.startswith('~')):
            # relative paths are made absolute here
            src = os.path.join(os.getcwd(), src)
        sources = sorted(glob(os.path.expanduser(src)))
        if not sources:
            continue
        if dst.endswith('/'):
            # Its a directory. each file should be copied
            for path in sources:
                mkdir(os.path.expanduser(dst))
                ldst = os.path.expanduser('{}{}'.format(dst, os.path.basename(path)))
                if os.path.islink(ldst):
                    os.unlink(ldst)
                elif os.path.exists(ldst):
                    raise RuntimeError('{} already exists and is not controlled by us!'.format(ldst))
                assert not os.path.islink(ldst)
                path = os.path.expanduser(path)
                os.symlink(path, ldst, target_is_directory=os.path.isdir(path))
        elif os.path.isfile(sources[0]):
            # Combine/link into file
            dst = os.path.expanduser(dst)
            mkdir(os.path.dirname(dst))
            with open(dst, 'w') as outf:
                outf.write('# AUTOMATICALLY GENERATED DO NOT EDIT! \n')
                for path in sources:
                    with open(path, 'r') as f:
                        outf.write('## {}\n'.format(path))
                        outf.write(f.read())
                        outf.write('\n')
        elif os.path.isdir(sources[0]):
            ldst = os.path.expanduser(dst)
            if os.path.islink(ldst):
                os.unlink(ldst)
            elif os.path.exists(ldst):
                raise RuntimeError('{} already exists and is not controlled by us!'.format(ldst))
            assert not os.path.islink(ldst)
            os.symlink(os.path.expanduser(path), ldst, target_is_directory=True)

def install_taps(taps):
    for tap in taps:
        runcmd('brew tap {}'.format(tap))


def install_brew(pkgs, tags):
    already_installed = set(runcmd('brew list').strip().split('\n'))
    to_install = set(pkgs) - already_installed
    if to_install:
        print('Installing {} homebrew formulae'.format(len(to_install)))
        with NamedTemporaryFile('w') as tf:
            tf.write('\n'.join(to_install))
            tf.flush()
            runcmd('xargs <{} brew install'.format(tf.name))


def install_casks(pkgs, tags):
    # These need to be installed in a usable command line as some casks
    # ask for a password
    already_installed = set(runcmd('brew cask list').strip().split('\n'))
    casks = []
    for cask in pkgs:
        if is_str(cask):
            casks.append(cask)
        elif isinstance(cask, dict):
            if 'name' in cask and 'when' in cask and cask['when'] in tags:
                casks.append(cask['name'])

    to_install = set(casks) - already_installed
    if to_install:
        with open('/tmp/casks', 'w') as f:
            f.write('\n'.join(to_install))


def install_mas(apps, tags):
    appids = [runcmd(['mas search "{}"'.format(app)]).split(' ')[0] for app in apps]
    already_installed = set(c.split()[0] for c in runcmd('mas list').strip().split('\n'))
    to_install = set(appids) - already_installed
    if to_install:
        print('Installing {} apps from the Mac App Store'.format(len(to_install)))
        with NamedTemporaryFile() as tf:
            tf.write('\n'.join(to_install))
            tf.flush()
            runcmd('xargs <{} mas install'.format(tf.name))


def check_install_deps_macos():
    if not os.path.isdir(os.path.expanduser("~/homebrew/Cellar")):
        print('installing homebrew for the current user')
        runcmd('mkdir ~/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/homebrew')
    if not os.path.isfile('/usr/local/bin/mas'):
        print('Installing mas')
        runcmd('brew install mas')


def post_install(config):
    scripts = config.get('post-install', [])
    if isinstance(scripts, str):
        scripts = [scripts]
    for script in scripts:
        runcmd(script)


def install_from_config(config_file, tags):
    with open(config_file, 'r') as f:
        config = json.loads(f.read(), object_pairs_hook=collections.OrderedDict)

    try:
        os.mkdir(os.path.expanduser("~/.config/zsh"))
    except OSError:
        pass
    # FIXME: only do the following four on macos hosts
    if platform.system() == 'Darwin':
        check_install_deps_macos()
        install_taps(config.get('taps', []))
        install_brew(config.get('brew', []), tags)
        install_casks(config.get('casks', []), tags)
        install_mas(config.get('mas', []), tags)
    install_sources(config.get('sources', {}))
    install_symlinks(config.get('symlinks', {}))
    post_install(config)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("{}: CONFIG [TAGS]")
        sys.exit(1)
    tags = []
    if len(sys.argv) > 2:
        tags = sys.argv[2:]

    install_from_config(sys.argv[1], tags)
