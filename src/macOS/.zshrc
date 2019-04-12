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
export GEM_HOME=/usr/local/lib/ruby/gems
export PATH=/usr/local/lib/ruby/gems/2.5.0/bin:$PATH
export PATH="/usr/local/opt/ruby/bin:$PATH"

alias cls=clear
alias openremote='open $(git remote get-url origin)'
