#!/bin/sh


envdir=$(pwd)


echo "Deploying environment..."

# create infrastructure
echo "Creating infrastructure..."
for dir in "$HOME/.moc" "$HOME/.vim/swp" "$HOME/.rtorrent/session" \
           "$HOME/.irssi/scripts"; do
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
printf "Creating symlinks... "
# moc
ln -s "$envdir/dotfiles/moc_config" "$HOME/.moc/config"
# vim
ln -s "$envdir/dotfiles/vimrc" "$HOME/.vimrc"
# rtorrent
ln -s "$envdir/dotfiles/rtorrent.rc" "$HOME/.rtorrent.rc"
# irssi
ln -s "$envdir/plugins/irssi/hilightwin.pl" "$HOME/.irssi/scripts/hilightwin.pl"
echo "done."

echo "Deployed environment."
