#!/bin/sh

#
# apodget
#   A simple shell script that downloads pictures from
#   Sean Reiser's Astronomy Picture of the Day feed.
#
# Copyleft (C) 2010 Per Andersson <avtobiff@gmail.com>
#

set -e

OUTDIR=~/images/apod
FILES=$(wget -O - http://feeds.feedburner.com/seanreiser/apod | sed -n '/media:content/ {s/.*url="\([^"]*\)".*/\1/; p}')

cd $OUTDIR
for url in $FILES; do
    wget -nc "$url"
done
