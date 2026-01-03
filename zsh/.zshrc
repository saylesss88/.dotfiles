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

if [[ -f /run/.containerenv ]]; then
    export PROMPT="[arch] %n@%m %~ %# "
fi

export TERM=xterm-256color
unset LINES
unset COLUMNS

# Force prompt redraw
# precmd() {
#     zle && zle -R
# }

# User specific aliases and functions
if [ -d ~/.zshrc.d ]; then
    for rc in ~/.zshrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

