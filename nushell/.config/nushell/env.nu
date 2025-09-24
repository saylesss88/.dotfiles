# env.nu
#
# Installed by:
# version = "0.107.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.
#
# History configuration
$env.HISTORY_FILE_SIZE = 5000
$env.HISTORY_SIZE = 5000

# FZF configurations
$env.FZF_CTRL_T_OPTS = "--preview 'bat -n --color=always --line-range :500 {}'"
$env.FZF_ALT_C_OPTS = "--preview 'eza --tree --color=always {} | head -200'"

zoxide init nushell | save -f ~/.zoxide.nu
