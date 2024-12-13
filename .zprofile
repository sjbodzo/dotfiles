if [[ $OSTYPE == darwin* ]]; then
	alias flush='dscacheutil -flushcache'
fi
alias forge='$HOME/forge'
alias switch="nix run nix-darwin -- switch --flake ~/.config/nix-darwin"

[ -x "$(command -v eza)" ] && alias ll='eza -l'
[ -x "$(command -v kubectl)" ] && alias k='kubectl'
[ -x "$(command -v op)" ] && alias op_login = "eval (op signin)"
[ -x "$(command -v git)" ] \
    && alias gg="git log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
