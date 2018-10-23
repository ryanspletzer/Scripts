if not pgrep gpg-agent > nul
    eval 'gpg-agent --daemon'
end

export GPG_TTY='tty'

alias cls=clear
