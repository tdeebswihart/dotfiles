#!/usr/bin/env python3
import click
from collections import defaultdict
from datetime import datetime as dt
import os
from pathlib import Path
import sqlite3

confdir = Path.home() / ".config" / "keep_it"
try:
    confdir.mkdir()
except FileExistsError:
    pass

SEP = '\n---------------\n\n'

def pages_with_tag(db, tagname):
    return db.execute(f'''SELECT ZNAME,ZIDENTIFIER,ZTAGNAMES from ZITEM where ZTAGNAMES like "%{tagname}%''')

@click.command()
def main():
    envvars = confdir / "vars.txt"
    evars = {}
    with envvars.open('r') as e:
        for line in e:
            parts = line.strip().split('=')
            evars[parts[0]] = parts[1]
    db = sqlite3.connect(Path.home() / evars['KEEPIT_DB'])
    keepit = Path.home() / evars['KEEPIT_FILES']
    rev_idx = defaultdict(list)
    for tagpat in evars['TAGPATS'].split(','):
        # TODO: get the individual tags here
        for (name, ident, tags) in pages_with_tag(db, tagpat):
            for tag in tags.split(','):
                rev_idx[tag].append((name, ident))
        for tag, items = rev_idx.items():
            # topic:the reasoned schemer -> The Reasoned Schemer.md
            name = topic.split(':').strip().title()
            tagidx = keepit / f'_{name}.md'
            if tagname == "*" or not tagname:
                continue
            hdr = None
            prev = []
            if not tagidx.exists():
                # TODO: create header
                hdr = f"# {name}\n"
                with tagidx.open('w') as tagf:
                    tagf.write(hdr)
            idxlink =


if __name__ == '__main__':
    main()
