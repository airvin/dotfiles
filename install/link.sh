#!/usr/bin/env bash

set -euo pipefail

DOTFILES="${HOME}/.dotfiles"

echo
echo "Creating symlinks"
echo "=============================="
while IFS= read -r -d '' file; do
	target="${HOME}/.$(basename "$file" ".symlink")"
	if [[ -e "$target" || -L "$target" ]]; then
		echo "~${target#$HOME} already exists... Skipping."
	else
		echo "Creating symlink for $file"
		ln -s "$file" "$target"
	fi
done < <(find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' -print0)

echo
echo "installing to ~/.config"
echo "=============================="
if [[ ! -d "${HOME}/.config" ]]; then
	echo "Creating ~/.config"
	mkdir -p "${HOME}/.config"
fi
nvim_config="$DOTFILES/nvim"
if [[ -d "$nvim_config" ]]; then
	target="${HOME}/.config/nvim"
	if [[ -e "$target" || -L "$target" ]]; then
		echo "~${target#$HOME} already exists... Skipping."
	else
		echo "Creating symlink for $nvim_config"
		ln -s "$nvim_config" "$target"
	fi
fi

