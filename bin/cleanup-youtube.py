import click
import os
import re
import subprocess


@click.command()
@click.argument('path', type=click.Path(exists=True, file_okay=False))
@click.option('-a', '--album', default=None)
@click.option('-r', '--artist', default=None)
@click.option('-e', '--extension', default='m4a')
@click.option('-o', '--output', default=None)
def main(path, album, artist, extension, output):
    rgx = re.compile(r'.*?(\d+) - (.*?)-.*?.{}'.format(extension))
    for f in os.listdir('.'):
        m = rgx.match(f)
        if m:
            num = m.group(1)
            name = m.group(2)
            newname = '{}.{}'.format(name, extension)
            os.rename(f, newname)
            try:
                if extension == 'mp3':
                    cli = ['id3tag', '--song={}'.format(name), '--track={}'.format(num)]
                    if album is not None:
                        cli.append('--album={}'.format(album))
                    if artist is not None:
                        cli.append('--artist={}'.format(artist))
                    cli.append(newname)
                elif extension == 'm4a':
                    cli = ['mp4tags', '-song', name, '-track', num]
                    if album is not None:
                        cli.extend(['-album', album])
                    if artist is not None:
                        cli.extend(['-artist', artist])
                    cli.append(newname)
                else:
                    raise Exception('Unsupported extension!')

                subprocess.check_output(cli)
            except subprocess.CalledProcessError as e:
                os.rename(newname, f)
                raise
            print('{}\t{}'.format(num, name))

if __name__ == "__main__":
    main()
