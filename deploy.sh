#!/bin/sh


envdir=$(pwd)


echo "Deploying environment..."

# create infrastructure
echo "Creating infrastructure..."
for dir in "$HOME/.irssi/scripts" "$HOME/.moc" "$HOME/.rtorrent/session" \
           "$HOME/.vim/swp" "$HOME/.vim/undo" "$HOME/.wmii-3.5" "$HOME/.xmonad"; do
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
# devscripts
ln -s "$envdir/dotfiles/devscripts" "$HOME/.devscripts"
# git-buildpackage
ln -s "$envdir/dotfiles/gbp.conf" "$HOME/.gbp.conf"
# irssi
ln -s "$envdir/plugins/hilightwin.pl" "$HOME/.irssi/scripts/hilightwin.pl"
# lintian
ln -s "$envdir/dotfiles/lintianrc" "$HOME/.lintianrc"
# moc
ln -s "$envdir/dotfiles/moc_config" "$HOME/.moc/config"
# quilt
ln -s "$envdir/dotfiles/quiltrc" "$HOME/.quiltrc"
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
# xmonad
ln -s "$envdir/dotfiles/xmonad/xmonad.hs" "$HOME/.xmonad/xmonad.hs"
[ -x "$(which xmonad)" ] && xmonad --recompile
ln -s "$envdir/dotfiles/xmonad/xmobarrc" "$HOME/.xmobarrc"
# xsession
ln -s "$envdir/dotfiles/xsession" "$HOME/.xsession"

echo "Deployed environment."
