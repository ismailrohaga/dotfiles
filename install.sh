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

# Check dependencies first
check_dependencies

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check dependencies
check_dependencies() {
    echo -e "${BLUE}🔍 Checking dependencies...${NC}"
    
    local missing_deps=()
    
    # Check required dependencies
    if ! command_exists brew; then
        missing_deps+=("homebrew")
    fi
    
    if ! command_exists aerospace; then
        missing_deps+=("aerospace")
    fi
    
    if ! command_exists sketchybar; then
        missing_deps+=("sketchybar")
    fi
    
    if ! command_exists fish; then
        missing_deps+=("fish")
    fi
    
    if ! command_exists nvim; then
        missing_deps+=("neovim")
    fi
    
    if ! command_exists wezterm; then
        missing_deps+=("wezterm")
    fi
    
    # Check optional dependencies
    local optional_missing=()
    
    if ! command_exists pyenv; then
        optional_missing+=("pyenv")
    fi
    
    if ! command_exists nvm; then
        optional_missing+=("nvm")
    fi
    
    if ! command_exists fzf; then
        optional_missing+=("fzf")
    fi
    
    if ! command_exists btop; then
        optional_missing+=("btop")
    fi
    
    # Report missing dependencies
    if [ ${#missing_deps[@]} -gt 0 ]; then
        echo -e "${RED}❌ Missing required dependencies:${NC}"
        printf '%s\n' "${missing_deps[@]}" | sed 's/^/  - /'
        echo
        echo -e "${YELLOW}📋 Install missing dependencies with:${NC}"
        echo -e "${BLUE}brew install --cask aerospace sketchybar wezterm${NC}"
        echo -e "${BLUE}brew install fish neovim${NC}"
        echo
        echo -e "${YELLOW}⚠️  Please install missing dependencies first, then run this script again.${NC}"
        exit 1
    fi
    
    if [ ${#optional_missing[@]} -gt 0 ]; then
        echo -e "${YELLOW}⚠️  Optional dependencies missing:${NC}"
        printf '%s\n' "${optional_missing[@]}" | sed 's/^/  - /'
        echo -e "${BLUE}💡 Install with: brew install pyenv nvm fzf btop${NC}"
        echo
    fi
    
    echo -e "${GREEN}✅ All required dependencies found!${NC}"
    echo
}

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

# Fish Shell
create_symlink "$DOTFILES_DIR/config/fish" "$HOME/.config/fish"

# WezTerm
create_symlink "$DOTFILES_DIR/config/wezterm" "$HOME/.config/wezterm"

# Btop
create_symlink "$DOTFILES_DIR/config/btop" "$HOME/.config/btop"

echo
echo -e "${BLUE}🔐 Setting up secure environment...${NC}"
# Create secrets directory if it doesn't exist
mkdir -p "$HOME/.config/env"
if [[ ! -f "$HOME/.config/env/secrets.sh" ]]; then
    cat > "$HOME/.config/env/secrets.sh" << 'EOF'
#!/bin/bash

# Private API Keys and Secrets
# This file should NOT be committed to version control

# Add your API keys here:
# export ANTHROPIC_API_KEY="your-anthropic-key-here"
# export OPENAI_API_KEY="your-openai-key-here"
# export GITHUB_TOKEN="your-github-token-here"
EOF
    chmod 600 "$HOME/.config/env/secrets.sh"
    echo -e "${GREEN}✅ Created secure secrets file at ~/.config/env/secrets.sh${NC}"
    echo -e "${YELLOW}⚠️  Remember to add your API keys to this file!${NC}"
fi

echo
echo -e "${BLUE}🔧 Setting up executable permissions...${NC}"

# SketchyBar plugins
if [[ -d "$HOME/.config/sketchybar/plugins" ]]; then
    find "$HOME/.config/sketchybar/plugins" -type f -name "*.sh" -exec chmod +x {} \;
    echo -e "${GREEN}✅ Set executable permissions for SketchyBar plugins${NC}"
fi

if [[ -d "$DOTFILES_DIR/config/sketchybar/plugins" ]]; then
    find "$DOTFILES_DIR/config/sketchybar/plugins" -type f -name "*.sh" -exec chmod +x {} \;
    echo -e "${GREEN}✅ Set executable permissions for dotfiles SketchyBar plugins${NC}"
fi

# SketchyBar main config
if [[ -f "$HOME/.config/sketchybar/sketchybarrc" ]]; then
    chmod +x "$HOME/.config/sketchybar/sketchybarrc"
    echo -e "${GREEN}✅ Set executable permissions for SketchyBar config${NC}"
fi

# SketchyBar items
if [[ -d "$HOME/.config/sketchybar/items" ]]; then
    find "$HOME/.config/sketchybar/items" -type f -name "*.sh" -exec chmod +x {} \;
    echo -e "${GREEN}✅ Set executable permissions for SketchyBar items${NC}"
fi

# Fish config
if [[ -f "$HOME/.config/fish/config.fish" ]]; then
    chmod 644 "$HOME/.config/fish/config.fish"
    echo -e "${GREEN}✅ Set proper permissions for Fish config${NC}"
fi

# Shell files
chmod 644 "$HOME/.zshrc" "$HOME/.zprofile" "$HOME/.profile" 2>/dev/null || true
echo -e "${GREEN}✅ Set proper permissions for shell configs${NC}"

# AeroSpace config
if [[ -f "$HOME/.aerospace.toml" ]]; then
    chmod 644 "$HOME/.aerospace.toml"
    echo -e "${GREEN}✅ Set proper permissions for AeroSpace config${NC}"
fi

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