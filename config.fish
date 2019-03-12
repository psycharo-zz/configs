set fish_greeting ""

if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end
fundle plugin 'edc/bass'
fundle plugin 'tuvistavie/fish-kubectl'
#fundle plugin 'tuvistavie/fish-ssh-agent'
fundle plugin 'tuvistavie/fish-fastdir'
fundle plugin 'brgmnn/fish-docker-compose'
fundle init

set -x TERM "xterm-256color"

alias e "emacsclient -t"
alias emacs "emacs -nw --no-splash"