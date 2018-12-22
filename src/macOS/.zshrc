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
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH

alias cls=clear
