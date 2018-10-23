if not pgrep gpg-agent > nul
    eval 'gpg-agent --daemon'
end

set -x GPG_TTY (tty)

alias cls=clear
