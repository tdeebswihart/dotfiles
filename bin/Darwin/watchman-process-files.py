#!/usr/bin/env python3
"""
TODO: allow multiple rules to interact per file (but only one that renames it).
"""
import os
import re
import sys

def remove_dotdot(path):
    # Not allowed
    new_path = path.replace('..', '')
    while new_path != path:
        path = new_path
        new_path = path.replace('..', '')
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
    if len(components) != 3:
        raise ValueError(f"Invalid rule: '{line}'")
    return (re.compile(components[0]),
            remove_dotdot(components[1]),
            components[2])


def expand_variables(variables, text):
    for variable, value in variables.items():
        key = f'{{{variable}}}'
        if key in text:
            # print(f'Replacing {key} with {value} in {text}')
            text = text.replace(key, value)
    return text


def process_file(rules, variables, path: str):
    basename = os.path.basename(path)
    for (pattern, folder_tmpl, tag_tmpl) in rules:
        m = pattern.match(path)
        if not m:
            continue
        groups = m.groups()
        full_path = folder_tmpl.replace('{basename}', basename)
        group_vars = {f'{idx + 1}': group for idx, group in enumerate(m.groups())}
        local_vars = {**group_vars, **variables}
        new_path = os.path.expanduser(expand_variables(local_vars, full_path))
        new_tags = expand_variables(local_vars, tag_tmpl)
        dirn = os.path.dirname(new_path)
        if not os.path.exists(dirn):
            os.mkdir(dirn)
        # print(f'{pattern} produced {new_path} from {path}')
        # TODO: don't rename until after we've applied all rules (to accumulate tag updates)
        # TODO: add tags here
        try:
            os.rename(path, new_path)
        except OSError as e:
            print(e)

if __name__ == '__main__':
    confdir = os.path.expanduser('~/.config/watchman/')
    if not os.path.exists(confdir):
        sys.exit(0)

    with open(os.path.join(confdir, 'rules.conf'), 'r') as f:
        variables, rules = parse_config(f)
    if len(sys.argv) > 0:
        for infile in sys.argv[1:]:
            process_file(rules, variables, infile)
    else:
        sys.exit(1)
