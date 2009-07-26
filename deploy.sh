#!/bin/sh


envdir=$(pwd)


echo "Deploying environment..."

# create infrastructure
echo "Creating infrastructure..."
for dir in "$HOME/.irssi/scripts" "$HOME/.moc" "$HOME/.rtorrent/session" \
           "$HOME/.vim/swp" "$HOME/.wmii-3.5"; do
    if [ -d "$dir" ]; then
        echo "I: Directory already exists: $dir."
    else
        printf "Creating $dir... "
        mkdir -p "$dir"
        echo "done."
    fi
done

## create symlinks.
## quick, dirty, and hardwired for now...
echo "Creating symlinks... "
# irssi
ln -s "$envdir/plugins/hilightwin.pl" "$HOME/.irssi/scripts/hilightwin.pl"
# moc
ln -s "$envdir/dotfiles/moc_config" "$HOME/.moc/config"
# rtorrent
ln -s "$envdir/dotfiles/rtorrent.rc" "$HOME/.rtorrent.rc"
# screen
ln -s "$envdir/dotfiles/screenrc" "$HOME/.screenrc"
# vim
ln -s "$envdir/dotfiles/vimrc" "$HOME/.vimrc"
# wmii
ln -s "$envdir/dotfiles/wmiirc" "$HOME/.wmii-3.5/wmiirc"
# Xdefaults
ln -s "$envdir/dotfiles/Xdefaults" "$HOME/.Xdefaults"

echo "Deployed environment."
