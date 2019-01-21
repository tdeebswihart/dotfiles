#!/usr/bin/env python3
"""
TODO: allow multiple rules to interact per file (but only one that renames it).
"""
from collections import defaultdict
import os
import re
import sys
from subprocess import check_output, STDOUT
from tempfile import NamedTemporaryFile

add_tmpl = '  add files {{POSIX file "{name}"}} by moving to ({fldr}) with tags {{{tags}}}'

script = """
use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

tell application "Keep It"
  repeat until top level folder is not missing value
    delay 1
  end repeat
  set inbox to get folder id "A13B9FE9-7094-475F-8E9B-2452B3DEDCF0"
  {items}
end tell
"""

def remove_dotdot(path):
    # Not allowed
    new_name = path.replace('..', '')
    while new_name != path:
        path = new_name
        new_name = path.replace('..', '')
    return path


def parse_config(f):
    variables = {}
    rules = []
    for line in f:
        line = line.strip()
        if line.startswith('#') or len(line) == 0:
            continue
        elif line.startswith('!'): # variable definition
            parts = line.split('=')
            if len(parts) < 2:
                raise ValueError(f"Invalid variable specification {line}")
            # Drop the leading exclamation mark
            name = parts[0][1:]
            val = '='.join(parts[1:])
            variables[name] = val
        else:
            rules.append(parse_rule(line))
    return (variables, rules)

def parse_rule(line: str):
    components = line.split(':')
    if len(components) != 4:
        raise ValueError(f"Invalid rule: '{line}'")
    return (re.compile(components[0]),
            remove_dotdot(components[1]),
            remove_dotdot(components[2]),
            components[3])


def expand_variables(variables, text):
    for variable, value in variables.items():
        text = text.replace(f'{{{variable}}}', value)
    return text


def process_file(rules, variables, path: str, state: dict):
    basename = os.path.basename(path)
    dirname = os.path.dirname(path)
    tags = []
    name = basename
    folder = None
    for (pattern, name_tmpl, folder_tmpl, tag_tmpl) in rules:
        m = pattern.match(name)
        if not m:
            continue
        groups = m.groups()
        numbered_groups = {f'{idx + 1}': group for idx, group in enumerate(m.groups())}  # Numbered groups
        named_groups = {f'{k}': v for k, v in m.groupdict().items()}  # Named groups
        local_vars = {'{basename}': name, **named_groups, **numbered_groups, **variables}
        if name_tmpl:
            name = expand_variables(local_vars, name_tmpl)
        if folder_tmpl:
            folder = os.path.expanduser(expand_variables(local_vars, folder_tmpl))
        if tag_tmpl:
            tags.extend(expand_variables(local_vars, tag_tmpl).split(','))
    new_name = name
    if dirname:
        new_name = f'{dirname}/{name}'
    if name != path:
        try:
            os.rename(path, new_name)
        except OSError as e:
            print(e)
            return state
    if tags:
        if not os.path.exists('/usr/local/bin/tag'):
            raise RuntimeError("Please run `brew install tag'")
        check_output(['/usr/local/bin/tag', '--add', ','.join(tags), new_name])
    # TODO: find a better way to specify this...
    if folder is not None:
        if folder.startswith('!keepit'):
            folder = folder.replace('!keepit', '').strip('/')
            if folder:
                folder = (" of ".join(f"folder \"{fl}\"" for fl in reversed(folder.split('/')))
                        + " of top level folder")
            else:
                folder = "inbox"
            state['keepit'].append(add_tmpl.format(
                name=os.path.abspath(new_name),
                fldr=folder,
                tags=', '.join(f'"{t}"' for t in tags)))
        else:
            # TODO: move it!
            try:
                os.rename(os.path.abspath(new_name),
                          os.path.join(folder, new_name))
            except OSError as e:
                print(e)
    return state

if __name__ == '__main__':
    confdir = os.path.expanduser('~/.config/watchman/')
    if not os.path.exists(confdir):
        sys.exit(0)

    with open(os.path.join(confdir, 'rules.conf'), 'r') as f:
        variables, rules = parse_config(f)
    if len(sys.argv) > 0:
        exclusions = re.compile(variables.get('exclusions', '^$'))
        state = defaultdict(list)
        for infile in sys.argv[1:]:
            if not exclusions.match(infile):
                state = process_file(rules, variables, infile, state)
        items = state.get('keepit', [])
        if items:
            with NamedTemporaryFile(mode='w', delete=True) as tempf:
                scpt = script.format(items='\n'.join(items))
                tempf.write(scpt)
                tempf.flush()
                out = check_output(['/usr/bin/osascript', tempf.name], stderr=STDOUT)
                if out and out.strip() != b'true':
                    print(out.decode())

    else:
        sys.exit(1)
