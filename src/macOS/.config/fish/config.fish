if not pgrep gpg-agent > /dev/null
    eval 'gpg-agent --daemon'
end

set -x GPG_TTY (tty)

# Ruby gems / Jekyll
set -x GEM_HOME $HOME/gems
set -x PATH $PATH $HOME/gems/bin
set -x PATH $PATH /usr/local/opt/ruby/bin

alias cls=clear
