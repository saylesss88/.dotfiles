# To use these dotfiles, clone the repo to ~/.dotfiles. Install Gnu Stow

```bash
cd ~/.dotfiles
```

Stow the programs you want:

```bash
stow nvim
stow waybar
```

- This will place the files in the correct directories and use symlinks to this
  directory.

- [omz archlinux alias'](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/archlinux/README.md)

## Adding Different Configurations

### Zsh

```bash
# Create the stow package structure
mkdir -p ~/.dotfiles/zsh/.zshrc.d

# Move the main config (if not already done)
mv ~/.zshrc ~/.dotfiles/zsh/.zshrc

# Move all your zshrc.d snippets
mv ~/.zshrc.d/* ~/.dotfiles/zsh/.zshrc.d/
rmdir ~/.zshrc.d   # only if it's now empty
```
