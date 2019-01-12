#!/usr/bin/env python3
"""
Your REFRESH_TOKEN variable must have the scopes history,identity,read
"""

import click
from datetime import datetime as dt
import os
from pathlib import Path
import praw
import sys

confdir = Path.home() / ".config" / "reddit"
try:
    confdir.mkdir()
except FileExistsError:
    pass

SEP = '\n\n---\n\n'

def handle_comment(comment: praw.models.Comment) -> str:
    title = comment.submission.title
    link = comment.link_permalink
    subreddit = comment.subreddit.display_name
    body = comment.body.strip()
    sublink = f"https://reddit.com{comment.subreddit.url}"
    return f"""**[{title}]({link})** in _[{subreddit}]({sublink})_:\n\n{body}"""


def handle_submission(submission: praw.models.Submission) -> str:
    title = submission.title
    link = submission.url
    subreddit = submission.subreddit.url
    sublink = f"https://reddit.com{submission.subreddit.url}"
    return f"""**[{title}]({link})** (_[{subreddit}]({sublink})_:)"""


handlers = {'Comment': handle_comment, 'Submission': handle_submission}

@click.command()
def main():
    envvars = confdir / "vars.txt"
    evars = {}
    # I do this because it's a pain to set environment variables
    # for launchd, and I don't even need something as complicated as
    # YAML or TOML for configuration
    with envvars.open('r') as e:
        for line in e:
            parts = line.strip().split('=')
            evars[parts[0].lower()] = parts[1]

    api = praw.Reddit(**evars)
    conf = confdir / "last_processed"
    last_processed = None
    if conf.exists():
        with conf.open('r') as f:
            last_processed = f.readline().strip()
            if last_processed == '':
                last_processed = None

    me = api.user.me()
    processed = set()
    favs = me.saved(params={'before': last_processed})
    with conf.open('w') as f:
        while favs:
            # TODO: Ensure that this is correct
            fst = True
            for item in favs:
                if fst:
                    fst = False
                    last_processed = item.fullname
                typename = item.__class__.__name__
                try:
                    fmtd = handlers[typename](item)
                    if fmtd:
                        processed.add(fmtd)
                except KeyError as kerr:
                    print(f'Unexpected item type {typename}!')
            favs = me.saved(params={'before': last_processed})
            # Save our progress
            f.seek(0)
            f.write(str(latest_fav) + '\n')
            f.flush()
    if processed:
        favs = SEP.join(processed)
        now = dt.now()
        date = now.strftime("%Y-%m-%d")
        target =  (Path(evars['KEEPIT_FILES']) / "Life" / str(now.year) / f"{date} Saved Reddit Content.md")

        mode = 'w'
        hdr = f'# {date} Saved Reddit Content\n'
        if target.exists():
            # Append if it already exists
            mode = 'a'
            hdr = SEP
        with target.open(mode) as f:
            if hdr:
                f.write(hdr)
            f.write(favs)

if __name__ == "__main__":
    main()
