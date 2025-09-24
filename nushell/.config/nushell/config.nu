$env.config.buffer_editor = "hx"
$env.config.table.mode = "rounded"
# $env.config.table.mode = "basic"
$env.config.show_banner = false
$env.config.ls.use_ls_colors = true
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
$env.TOPIARY_CONFIG_FILE = ($env.XDG_CONFIG_HOME | path join topiary languages.ncl)
$env.TOPIARY_LANGUAGE_DIR = ($env.XDG_CONFIG_HOME | path join topiary languages)
alias y = yazi
alias upd = sudo pacman -Syu
alias ins = sudo pacman -S

# starship prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source ~/.zoxide.nu
source ~/.local/share/atuin/init.nu
use std/util "path add"
path add "~/.local/bin"
$env.CARGO_HOME = ($env.HOME | path join ".cargo")
path add ($env.CARGO_HOME | path join "bin")
