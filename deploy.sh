#!/bin/sh

set -e


envdir=$(pwd)


echo "Deploying environment..."

# create infrastructure
for dir in "$HOME/.moc" "$HOME/.vim/swp" "$HOME/.rtorrent/session"; do
    if [ -d "$dir" ]; then
        echo "I: Directory already exists: $dir."
    else
        printf "Creating $dir... "
        mkdir -p "$dir"
        echo "done."
    fi
done

# create symlinks.
for target in $(ls "$envdir"/dotfiles); do
    # dotfile.
    link_name=$(echo "$file" | sed 's/^/./')
    # take care of subdirectories.
    link_name=$(echo "$file" | sed 's,_,/,')
    if [ -f "$file" ]; then
        echo "E: File already exists: $file."
    elif [ -h "$file" ]; then
        echo "I: Symlink already exists: $file."
        echo "I: $(ls -l | awk '{print $8 " " $9 " " $10}')"
    else
        ln -s "$target" "$HOME/$link_name"
    fi
done

echo "Deployed environment."
