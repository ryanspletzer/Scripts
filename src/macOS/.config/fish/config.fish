if not pgrep gpg-agent > /dev/null
    eval 'gpg-agent --daemon'
end

set -x GPG_TTY (tty)

alias cls=clear
