#!/bin/bash

# Dotfiles Installation Script
# This script will symlink all dotfiles to their appropriate locations

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where the script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}🏠 Dotfiles Installation${NC}"
echo -e "${BLUE}========================${NC}"
echo -e "Installing from: ${DOTFILES_DIR}"
echo

# Function to create backup if file exists
backup_if_exists() {
    local file="$1"
    if [[ -e "$file" ]] && [[ ! -L "$file" ]]; then
        echo -e "${YELLOW}⚠️  Backing up existing $file to $file.backup${NC}"
        mv "$file" "$file.backup"
    fi
}

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Backup existing file if it exists and is not a symlink
    backup_if_exists "$target"
    
    # Remove existing symlink if it exists
    [[ -L "$target" ]] && rm "$target"
    
    # Create the symlink
    ln -sf "$source" "$target"
    echo -e "${GREEN}✅ Linked $source -> $target${NC}"
}

echo -e "${BLUE}📋 Installing shell configurations...${NC}"
create_symlink "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/shell/.zprofile" "$HOME/.zprofile"
create_symlink "$DOTFILES_DIR/shell/.profile" "$HOME/.profile"

echo
echo -e "${BLUE}🪟 Installing AeroSpace configuration...${NC}"
create_symlink "$DOTFILES_DIR/aerospace/.aerospace.toml" "$HOME/.aerospace.toml"

echo
echo -e "${BLUE}⚙️  Installing application configurations...${NC}"
mkdir -p "$HOME/.config"

# SketchyBar
create_symlink "$DOTFILES_DIR/config/sketchybar" "$HOME/.config/sketchybar"

# Neovim
create_symlink "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"

# Fish Shell
create_symlink "$DOTFILES_DIR/config/fish" "$HOME/.config/fish"

# WezTerm
create_symlink "$DOTFILES_DIR/config/wezterm" "$HOME/.config/wezterm"

# Btop
create_symlink "$DOTFILES_DIR/config/btop" "$HOME/.config/btop"

echo
echo -e "${BLUE}🔧 Setting up executable permissions...${NC}"
chmod +x "$HOME/.config/sketchybar/plugins/"*.sh 2>/dev/null || true
chmod +x "$DOTFILES_DIR/config/sketchybar/plugins/"*.sh 2>/dev/null || true

echo
echo -e "${GREEN}🎉 Installation complete!${NC}"
echo
echo -e "${YELLOW}📝 Next steps:${NC}"
echo -e "  1. Restart your terminal or run: ${BLUE}source ~/.zshrc${NC}"
echo -e "  2. Restart AeroSpace: ${BLUE}aerospace reload-config${NC}"
echo -e "  3. Restart SketchyBar: ${BLUE}sketchybar --reload${NC}"
echo
echo -e "${BLUE}💡 Tips:${NC}"
echo -e "  • Customize colors in ~/.config/sketchybar/colors.sh"
echo -e "  • Modify AeroSpace keybindings in ~/.aerospace.toml"
echo -e "  • Check the README.md for more information"
echo

# Check if we're in a git repository and suggest next steps
if [[ -d "$DOTFILES_DIR/.git" ]]; then
    echo -e "${BLUE}🔄 Git Repository Detected${NC}"
    echo -e "  • To push to GitHub: Set up a remote repository and run:"
    echo -e "    ${BLUE}git remote add origin https://github.com/ismailrohaga/dotfiles.git${NC}"
    echo -e "    ${BLUE}git branch -M main${NC}"
    echo -e "    ${BLUE}git push -u origin main${NC}"
fi

echo -e "\n${GREEN}Happy configuring! 🚀${NC}" 