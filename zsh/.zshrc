# .zshrc

# Source global definitions
if [ -f /etc/zshrc ]; then
    . /etc/zshrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# if [[ -f /run/.containerenv ]]; then
#     export PROMPT="[distrobox] %n@%m %~ %# "
# fi

if [[ -f /run/.containerenv ]]; then
    box="${CONTAINER_ID:-${DBS_CONTAINER_NAME:-$HOSTNAME}}"
    PROMPT="[$box] %n@%m %~ %#"
fi

export TERM=xterm-256color
unset LINES
unset COLUMNS

export EDITOR=hx

export LIBVIRT_DEFAULT_URI="qemu:///system"

# Force prompt redraw
# precmd() {
#     zle && zle -R
# }

# User specific aliases and functions
# 
if [ -d ~/.zshrc.d ]; then
  for rc in ~/.zshrc.d/*(N.); do
    . "$rc"
  done
fi

# if [ -d ~/.zshrc.d ]; then
#     for rc in ~/.zshrc.d/*; do
#         if [ -f "$rc" ]; then
#             . "$rc"
#         fi
#     done
# fi
# unset rc

HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=10000




# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# slasher-horrorscripts --random
