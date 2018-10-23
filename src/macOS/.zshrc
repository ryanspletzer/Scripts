if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

if [ -z "$(pgrep gpg-agent)" ]; then
    eval $(gpg-agent --daemon)
fi

export GPG_TTY=$(tty)

alias cls=clear
