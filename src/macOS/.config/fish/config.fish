if not pgrep gpg-agent > /dev/null
    eval 'gpg-agent --daemon'
end

set -x GPG_TTY (tty)

# Ruby gems / Jekyll
set -x GEM_HOME /usr/local/lib/ruby/gems
set -x PATH $PATH /usr/local/lib/ruby/gems/2.5.0/bin
set -x PATH $PATH /usr/local/opt/ruby/bin

alias cls=clear
alias openremote='open $(git remote get-url origin)'
