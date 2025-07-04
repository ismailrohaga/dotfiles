export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"
plugins=(
  git
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

#############################
# User Configurations
#############################

# API Keys - Load from separate file for security
[ -f ~/.config/env/secrets.sh ] && source ~/.config/env/secrets.sh

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fzf (fuzzy finder)
# Load fzf if installed.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Pub Cache
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# SSH Agent Setup
# eval "$(ssh-agent -s)" > /dev/null 2>&1
# ssh-add ~/.ssh/id_rsa > /dev/null 2>&1

#############################
# Aliases and Functions
#############################

# Alias to open the .zshrc config file quickly
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# Reload .zshrc
reload() {
  source ~/.zshrc
  echo "ZSH config reloaded!"
}

# Directory picker using fzf for fast navigation
export CONFIG_DIR="$HOME/.config"
alias dir='function _dir() {
  local dir
  dir=$(find ~/Project -maxdepth 3 -type d \( -name ".*" -prune \) -o -type d -print | fzf --height 40% --border --ansi --prompt="Select directory: ")
  if [ -n "$dir" ]; then
    cd "$dir"
  else
    echo "No directory selected."
  fi
}; _dir'


dev() {
  cd ~/Development
  echo "=================== Development Directory ==================="
  ls -a
  dir
}

. "$HOME/.local/bin/env"

# bun completions
[ -s "/Users/ismailrohaga/.bun/_bun" ] && source "/Users/ismailrohaga/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
