#!/usr/bin/env bash
set -e

# 1. Define the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 2. Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Cloning Oh My Zsh..."
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

# 3. Symlink standard configuration files
declare -a STANDARD_FILES=(
  ".zshrc"
  ".vimrc"
)

for FILE in "${STANDARD_FILES[@]}"; do
  ln -sf "$DOTFILES_DIR/$FILE" "$HOME/$FILE"
  echo "Linked $FILE → $HOME/$FILE"
done

# 4. Symlink special-case files (source → destination)
SPECIAL_SRC_FILES=("karabiner.json")
SPECIAL_DEST_FILES=("$HOME/.config/karabiner/karabiner.json")

for i in "${!SPECIAL_SRC_FILES[@]}"; do
  SRC="${SPECIAL_SRC_FILES[$i]}"
  DEST="${SPECIAL_DEST_FILES[$i]}"
  DEST_DIR=$(dirname "$DEST")
  mkdir -p "$DEST_DIR"
  ln -sf "$DOTFILES_DIR/$SRC" "$DEST"
  echo "Linked $SRC → $DEST"
done


# 5. Symlink .vim directory
ln -sfn "$DOTFILES_DIR/.vim" "$HOME/.vim"
echo "Linked .vim directory → $HOME/.vim"

# 6. Clone flazz/vim-colorschemes into ~/.vim/colors
COLORS_DIR="$HOME/.vim/colors"
if [ ! -d "$COLORS_DIR" ]; then
  mkdir -p "$COLORS_DIR"
fi

if [ ! -d "$HOME/.vim/vim-colorschemes" ]; then
  echo "Cloning vim-colorschemes..."
  git clone https://github.com/flazz/vim-colorschemes.git "$HOME/.vim/vim-colorschemes"
fi

cp -r "$HOME/.vim/vim-colorschemes/colors/"* "$COLORS_DIR/"
echo "Copied vim-colorschemes to $COLORS_DIR"

# 7. Configure iTerm2 preferences (macOS only)
if [[ "$(uname)" == "Darwin" ]]; then
  echo "Configuring iTerm2 preferences..."
  defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES_DIR"
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
  echo "Configured iTerm2 to load preferences from $DOTFILES_DIR"
fi

echo "✅ Dotfiles installation complete."

