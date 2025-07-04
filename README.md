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

- [Homebrew](https://brew.sh/)
- [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- [SketchyBar](https://github.com/FelixKratz/SketchyBar)

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
ln -sf ~/.dotfiles/config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/config/fish ~/.config/fish
ln -sf ~/.dotfiles/config/wezterm ~/.config/wezterm
ln -sf ~/.dotfiles/config/btop ~/.config/btop
```

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

## 🤝 Contributing

If you find bugs or have improvements, feel free to open an issue or PR!

## 📄 License

MIT License - feel free to use and modify as needed.

---

> **Note**: These dotfiles are tailored for macOS. Some configurations may not work on other operating systems.
