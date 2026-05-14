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

echo
echo "Installing VS Code settings"
echo "=============================="
vscode_config_dir="$DOTFILES/vscode"
case "$(uname)" in
	Darwin)
		vscode_user_dir="$HOME/Library/Application Support/Code/User"
		;;
	Linux)
		vscode_user_dir="$HOME/.config/Code/User"
		;;
	*)
		vscode_user_dir=""
		;;
esac

if [[ -d "$vscode_config_dir" && -n "$vscode_user_dir" ]]; then
	mkdir -p "$vscode_user_dir"
	for file in settings.json keybindings.json; do
		source_file="$vscode_config_dir/$file"
		target="$vscode_user_dir/$file"
		if [[ ! -e "$source_file" ]]; then
			continue
		fi
		if [[ -e "$target" || -L "$target" ]]; then
			echo "~${target#$HOME} already exists... Skipping."
		else
			echo "Creating symlink for $source_file"
			ln -s "$source_file" "$target"
		fi
	done
elif [[ -d "$vscode_config_dir" ]]; then
	echo "Unsupported OS for automatic VS Code settings install... Skipping."
fi

