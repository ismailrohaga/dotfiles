# 🏠 Dotfiles

My personal macOS dotfiles and configuration setup.

## 📁 Structure

```
├── aerospace/          # AeroSpace window manager config
│   └── .aerospace.toml
├── config/             # XDG config directory contents
│   ├── sketchybar/     # SketchyBar status bar
│   ├── nvim/           # Neovim configuration
│   ├── fish/           # Fish shell config
│   ├── wezterm/        # WezTerm terminal config
│   └── btop/           # Btop system monitor
├── shell/              # Shell configuration files
│   ├── .zshrc
│   ├── .zprofile
│   └── .profile
└── install.sh          # Installation script
```

## ⚡ Features

- **🪟 AeroSpace**: Tiling window manager with workspace management
- **📊 SketchyBar**: Highly customizable status bar with workspace indicators
- **🐟 Fish Shell**: Modern shell with autocompletion and syntax highlighting
- **📝 Neovim**: Extensive editor configuration
- **💻 WezTerm**: GPU-accelerated terminal emulator
- **📈 Btop**: Beautiful system monitor

## 🚀 Installation

### Prerequisites

Make sure you have the following installed:

#### **Required Dependencies:**

- [Homebrew](https://brew.sh/) - Package manager for macOS
- [AeroSpace](https://github.com/nikitabobko/AeroSpace) - Tiling window manager
- [SketchyBar](https://github.com/FelixKratz/SketchyBar) - Status bar
- [Fish Shell](https://fishshell.com/) - Modern shell
- [Neovim](https://neovim.io/) - Text editor
- [WezTerm](https://wezfurlong.org/wezterm/) - Terminal emulator

#### **Optional Dependencies:**

- [pyenv](https://github.com/pyenv/pyenv) - Python version management
- [nvm](https://github.com/nvm-sh/nvm) - Node.js version management
- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
- [btop](https://github.com/aristocratos/btop) - System monitor

#### **Quick Install All Dependencies:**

```bash
# Install Homebrew first
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install main dependencies
brew install --cask aerospace sketchybar wezterm
brew install fish neovim fzf btop

# Install development tools
brew install pyenv nvm

# Install Oh My Zsh (for zsh configuration)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### Quick Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/ismailrohaga/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Run the install script:
   ```bash
   ./install.sh
   ```

### Manual Installation

If you prefer to install manually:

```bash
# Backup existing configs
cp ~/.aerospace.toml ~/.aerospace.toml.backup 2>/dev/null || true
cp ~/.zshrc ~/.zshrc.backup 2>/dev/null || true

# Create symlinks
ln -sf ~/.dotfiles/aerospace/.aerospace.toml ~/.aerospace.toml
ln -sf ~/.dotfiles/shell/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/shell/.zprofile ~/.zprofile
ln -sf ~/.dotfiles/shell/.profile ~/.profile

# Config directory symlinks
mkdir -p ~/.config
ln -sf ~/.dotfiles/config/sketchybar ~/.config/sketchybar
ln -sf ~/.dotfiles/config/fish ~/.config/fish
ln -sf ~/.dotfiles/config/wezterm ~/.config/wezterm
ln -sf ~/.dotfiles/config/btop ~/.config/btop
```

## 🔗 How Symlinks Work

**This is the magic of dotfiles!** Instead of copying files, we create **symbolic links (symlinks)** that point from your system's expected config locations to your dotfiles repository.

### What happens when you run `./install.sh`:

```bash
# Instead of copying files like this:
cp ~/.dotfiles/shell/.zshrc ~/.zshrc

# We create symlinks like this:
ln -sf ~/.dotfiles/shell/.zshrc ~/.zshrc
```

### 🎯 **The Benefits:**

- **✅ Single source of truth**: All configs live in `~/.dotfiles/`
- **✅ Automatic sync**: Edit in `~/.dotfiles/`, changes apply instantly
- **✅ Version control**: Track all changes with git
- **✅ Easy backup**: Push to GitHub, pull on any machine

### 🔍 **Example Workflow:**

```bash
# Edit your shell config
nvim ~/.dotfiles/shell/.zshrc

# Changes are immediately active because ~/.zshrc → ~/.dotfiles/shell/.zshrc
source ~/.zshrc

# Commit your changes
cd ~/.dotfiles
git add shell/.zshrc
git commit -m "Update shell aliases"
git push
```

### 📁 **Symlink Map:**

```
~/.zshrc                    → ~/.dotfiles/shell/.zshrc
~/.aerospace.toml           → ~/.dotfiles/aerospace/.aerospace.toml
~/.config/sketchybar/       → ~/.dotfiles/config/sketchybar/
~/.config/fish/             → ~/.dotfiles/config/fish/
~/.config/wezterm/          → ~/.dotfiles/config/wezterm/
~/.config/btop/             → ~/.dotfiles/config/btop/
```

## 🔐 Secure API Key Management

**Your API keys are now safely managed!** Instead of hardcoding sensitive information in your dotfiles, we use a separate secrets file.

### 🔍 **How It Works:**

```bash
# Your .zshrc loads secrets from a separate file
[ -f ~/.config/env/secrets.sh ] && source ~/.config/env/secrets.sh
```

### 📁 **Secrets File Location:**

```
~/.config/env/secrets.sh  # Your private API keys (NOT in git)
```

### 🛠️ **Managing Your API Keys:**

```bash
# Edit your secrets file
nvim ~/.config/env/secrets.sh

# Example content:
#!/bin/bash
export ANTHROPIC_API_KEY="your-anthropic-key-here"
export OPENAI_API_KEY="your-openai-key-here"
export GITHUB_TOKEN="your-github-token-here"
```

### 🔒 **Security Features:**

- **✅ Secure permissions** (600) - only you can read/write
- **✅ Not tracked by git** - added to `.gitignore`
- **✅ Automatic loading** - sourced by shell configuration
- **✅ Separate from dotfiles** - no accidental commits

### ⚠️ **Important Notes:**

- **Never commit secrets** to version control
- **Backup your secrets file** separately and securely
- **Use environment variables** for all sensitive data
- **Regenerate keys** if accidentally exposed

## 🔧 Configuration Highlights

### AeroSpace + SketchyBar Integration

The setup includes a seamless integration between AeroSpace and SketchyBar:

- Workspace indicators automatically highlight the active workspace
- Dynamic workspace creation based on AeroSpace configuration
- Smooth transitions and visual feedback

### Key Features:

- **Auto-highlighting**: Current workspace is visually distinguished
- **Click to switch**: Click workspace numbers to switch
- **Dynamic updates**: Real-time updates when switching workspaces

## 🔄 Keeping Up to Date

To update your dotfiles:

```bash
cd ~/.dotfiles
git pull origin main
```

## 🛠️ How to Configure/Update

### 1. Edit Configuration Files

```bash
# Edit AeroSpace configuration
nvim ~/.dotfiles/aerospace/.aerospace.toml

# Edit SketchyBar configuration
nvim ~/.dotfiles/config/sketchybar/sketchybarrc

# Edit Shell configuration
nvim ~/.dotfiles/shell/.zshrc
```

### 2. Test Your Changes

After making changes, test them:

```bash
# Reload AeroSpace
aerospace reload-config

# Reload SketchyBar
sketchybar --reload

# Reload Shell
source ~/.zshrc
```

### 3. Commit and Push Changes

```bash
cd ~/.dotfiles
git add .
git commit -m "Update configuration"
git push origin main
```

## 📝 Customization

Feel free to customize the configurations to your needs:

### Key Files to Customize:

- `aerospace/.aerospace.toml` - Window manager behavior
- `config/sketchybar/colors.sh` - Color scheme
- `config/sketchybar/sketchybarrc` - Status bar layout
- `shell/.zshrc` - Shell aliases and functions

## 🚨 Troubleshooting

### Common Issues and Solutions:

#### **"Command not found" errors:**

```bash
# Install missing dependencies
brew install --cask aerospace sketchybar wezterm
brew install fish neovim fzf btop pyenv nvm
```

#### **Permission denied errors:**

```bash
# Run the install script to fix permissions
cd ~/.dotfiles && ./install.sh
```

#### **SketchyBar not loading:**

```bash
# Check if SketchyBar is running
brew services restart sketchybar

# Check permissions
chmod +x ~/.config/sketchybar/sketchybarrc
chmod +x ~/.config/sketchybar/plugins/*.sh
```

#### **AeroSpace not working:**

```bash
# Restart AeroSpace
aerospace reload-config
```

#### **Fish shell not found:**

```bash
# Install fish and add to shells
brew install fish
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
```

#### **API keys not loading:**

```bash
# Check if secrets file exists and has proper permissions
ls -la ~/.config/env/secrets.sh
# Should show: -rw------- (600 permissions)

# If not, fix permissions:
chmod 600 ~/.config/env/secrets.sh
```

### **Getting Help:**

- Check the [AeroSpace documentation](https://github.com/nikitabobko/AeroSpace)
- Check the [SketchyBar documentation](https://github.com/FelixKratz/SketchyBar)
- Open an issue in this repository

## 🤝 Contributing

If you find bugs or have improvements, feel free to open an issue or PR!

## 📄 License

MIT License - feel free to use and modify as needed.

---

> **Note**: These dotfiles are tailored for macOS. Some configurations may not work on other operating systems.
