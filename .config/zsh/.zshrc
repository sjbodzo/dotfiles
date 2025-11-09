setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# Load the completion system before sourcing completions
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

for key in $HOME/.ssh/id_*(N.) $HOME/.ssh/*_id_*(N.); do
    [[ "$key" != *.pub ]] && ssh-add -q --apple-use-keychain "$key" 2>/dev/null
done

# configure $PATH
path=(
    $HOME/.local/bin
    /bin
    /usr/bin
    $path
)

(( $+commands[poetry] )) && path=("$HOME/.poetry/bin" $path)
# Add all Python framework versions (highest version first)
for pybin in /Library/Frameworks/Python.framework/Versions/*/bin(Non); do
    path=("$pybin" $path)
done
(( $+commands[go] )) && path=("$(go env GOPATH)/bin" $path)
(( $+commands[krew] )) && path=("${KREW_ROOT:-$HOME/.krew}/bin" $path)
(( $+commands[cargo] )) && path=("$HOME/.cargo/bin" $path)
(( $+commands[brew] )) && path=("/opt/homebrew/bin" $path)

fpath=(
	$HOME/.config/zsh/.zfunc                             # my custom functions
	"${fpath[@]}"                                        # expand existing fpath to not blow it away
)
autoload -Uz $fpath[1]/*                                 # source my custom functions

[[ -e "$HOME/.zprofile" ]] && \. $HOME/.zprofile         # source shell aliases

bindkey -v                                               # vim bindings in zsh

[ -f $HOME/.fzf.zsh ] && \. $HOME/.fzf.zsh
bindkey "${terminfo[kcuu1]}" fzf-history-widget

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# set dynamic coloring for all styles for ls colors
zstyle -e '*' list-colors 'reply=(${(s[:])LS_COLORS})'

## Sets key mappings for vim style, not "classic vi"
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char      # Control-h also deletes the previous char
bindkey "^U" backward-kill-line

# Source completions
[ -x "$(command -v minikube)" ] && \. <(minikube completion zsh)
[ -x "$(command -v kubectl)" ] && \. <(kubectl completion zsh)
[ -x "$(command -v kubectl-krew)" ] && \. <(kubectl krew completion zsh)
[ -x "$(command -v kind)" ] && \. <(kind completion zsh)
[ -x "$(command -v fzf)" ] && \. <(fzf --zsh) # only on fzf > 0.48
[ -x "$(command -v brew)" ] && [ -x "$(command -v az)" ] \
    && \. "$(brew --prefix)/etc/bash_completion.d/az"

# Configure helpers (s/w project tools)
[ -x "$(command -v direnv)" ] && eval "$(direnv hook zsh)"
[ -x "$(command -v pyenv)" ] && export PATH="$PYENV_ROOT/bin:$PATH" && eval "$(pyenv init -)"
[ -x "$(command -v fnm)" ] && eval "$(fnm env --use-on-cd)"
[ -x "$(command -v istioctl)" ] && export PATH="$PATH:/Users/jessbodzo/forge/bpam/istio-1.24.2/bin"
[ -s "${NVM_DIR:-"$HOME/.nvm"}/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "${NVM_DIR:-"$HOME/.nvm"}/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -x "$(command -v aws_completer)" ] && complete -C '/etc/profiles/per-user/jessbodzo/bin/aws_completer' # use aws cli autocomplete installed in nix profile

# source multi-user nix for shell
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# source nix-darwin
if [ -e '~/.nix-profile/etc/profile.d/nix-darwin.sh' ]; then
    . '~/.nix-profile/etc/profile.d/nix-darwin.sh'
fi

# Initialize starship last to properly wrap zle widgets
[ -x "$(command -v starship)" ] && eval "$(starship init zsh)"
