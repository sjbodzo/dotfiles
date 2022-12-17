if [[ $OSTYPE == darwin* ]]; then
	alias flush='dscacheutil -flushcache'
fi

alias k='kubectl'
alias gg="git log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias forge='$HOME/forge'
alias ll='exa -l'
