set -g -x PATH /usr/local/bin $PATH
set -g -x PATH /usr/bin $PATH
set -g -x fish_greeting ''

python -m virtualfish auto_activation compat_aliases | source
