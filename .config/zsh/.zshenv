if [ -e "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

export ZSH="$HOME/.oh-my-zsh"
export NVM_DIR="$HOME/.nvm"
export PYENV_ROOT="$HOME/.pyenv"
export GPG_TTY="$(tty)"
export EDITOR=nvim
export SHELL=zsh

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

export PATH="/opt/homebrew/opt/postgresql@12/bin:$PATH"

#export VIMRUNTIME=/Volumes/Riker/forge/nvim-macos/share/nvim/runtime
