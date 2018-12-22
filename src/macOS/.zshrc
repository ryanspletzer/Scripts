export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

if [ -z "$(pgrep gpg-agent)" ]; then
    eval $(gpg-agent --daemon)
fi

export GPG_TTY=$(tty)

# Ruby gems / Jekyll
export PATH="/usr/local/opt/ruby/bin:$PATH"

alias cls=clear
