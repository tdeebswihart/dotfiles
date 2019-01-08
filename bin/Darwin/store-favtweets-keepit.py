#!/usr/bin/env python3
import click
from datetime import datetime as dt
import os
from pathlib import Path
import twitter

confdir = Path.home() / ".config" / "twitter"
try:
    confdir.mkdir()
except FileExistsError:
    pass

SEP = '\n\n---\n\n'

@click.command()
def main():
    envvars = confdir / "vars.txt"
    evars = {}
    with envvars.open('r') as e:
        for line in e:
            parts = line.strip().split('=')
            evars[parts[0]] = parts[1]
    conf = confdir / "latest_favorite_id"
    tmpl = confdir / "favorite_template.md"
    api = twitter.Api(consumer_key=evars['TWITTER_API_KEY'],
                      consumer_secret=evars['TWITTER_API_SECRET_KEY'],
                      access_token_key=evars['TWITTER_ACCESS_TOKEN'],
                      access_token_secret=evars['TWITTER_ACCESS_TOKEN_SECRET'],
                      tweet_mode='extended')
    assert api.VerifyCredentials() != None, "Invalid credentials! Check your environment variables"

    latest_fav = None
    if conf.exists():
        with conf.open('r') as f:
            maybe_id = f.readline()
            try:
                latest_fav = int(maybe_id)
                # print(f"Picking back up with since_id={latest_fav}")
            except (TypeError, ValueError):
                print(f"Error creating tweet id from '{maybe_id}'")

    favorites = api.GetFavorites(since_id=latest_fav)
    favs = []
    with conf.open('w') as f:
        while favorites:
            latest_fav = max([s.id for s in favorites])
            for status in favorites:
                text = status.full_text if status.full_text else status.text
                link = f"https://twitter.com/{status.user.screen_name}/status/{status.id_str}"
                # Expand urls
                for url in status.urls:
                    text = text.replace(url.url, url.expanded_url)
                name = status.user.name
                datetime = status.created_at
                hashtags = ', '.join([f"{h.text}" for h in status.hashtags])
                hashtags = f"tags: {hashtags}" if hashtags else ''
                fmtd = f"**{name}** on _[{datetime}]({link})_:\n{text}\n\n{hashtags}"
                favs.append(fmtd)
            favorites = api.GetFavorites(since_id=latest_fav)
        # Save our progress
        f.seek(0)
        f.write(str(latest_fav) + '\n')
        f.flush()
    favs = SEP.join(favs)
    now = dt.now()
    date = now.strftime("%Y-%m-%d")
    target =  (Path(evars['KEEPIT_FILES']) / "Life" / str(now.year) / f"{date} Favorite Tweets.md")

    mode = 'w'
    hdr = f'# {date} Favorite Tweets\n'
    if target.exists():
        # Append if it already exists
        mode = 'a'
        hdr = SEP
    if favs:
        with target.open(mode) as f:
            if hdr:
                f.write(hdr)
            f.write(favs)

if __name__ == "__main__":
    main()
