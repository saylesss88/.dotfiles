$env.config.buffer_editor = "hx"
$env.config.edit_mode = "vi"
# The standard prompt indicator (used in Emacs mode, or Vi-Insert mode)
$env.PROMPT_INDICATOR = {|| $'(ansi light_yellow)»(ansi reset) ' }

# Vi Normal mode indicator: Executes the ansi command to color the 'V'
$env.PROMPT_INDICATOR_VI_NORMAL = {|| $'(ansi red_bold)V(ansi reset) ' }

# Vi Insert mode indicator: Executes the ansi command to color the 'i'
$env.PROMPT_INDICATOR_VI_INSERT = {|| $'(ansi green)i(ansi reset) ' }

# Multi-line indicator
$env.PROMPT_MULTILINE_INDICATOR = {|| $'(ansi dark_gray)…(ansi reset) ' }

$env.config.table.mode = "rounded"
# $env.config.table.mode = "basic"
$env.config.show_banner = false
$env.config.ls.use_ls_colors = true
$env.config.history = {
  file_format: sqlite
  max_size: 1_000_000
  sync_on_enter: true
  isolation: true
}
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.TOPIARY_CONFIG_FILE = ($env.XDG_CONFIG_HOME | path join topiary languages.ncl)
$env.TOPIARY_LANGUAGE_DIR = ($env.XDG_CONFIG_HOME | path join topiary languages)
$env.FZF_DEFAULT_OPTS = '--height 40% --tmux bottom,40% --layout reverse --border top'
$env.FZF_CTRL_T_OPTS = '--walker-skip .git,node_modules,target --preview "bat -n --color=always {}"--bind 'ctrl-/:change-preview-window(down|hidden|)''
# Aliases
alias y = yazi
alias upd = sudo pacman -Syu
alias up = paru -Syu
alias ins = sudo pacman -S
alias del = sudo pacman -Rs

# starship prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source ~/.zoxide.nu
source ~/.local/share/atuin/init.nu
use std/util "path add"
path add "~/.local/bin"
$env.CARGO_HOME = ($env.HOME | path join ".cargo")
path add ($env.CARGO_HOME | path join "bin")
source $"($nu.home-path)/.cargo/env.nu"
