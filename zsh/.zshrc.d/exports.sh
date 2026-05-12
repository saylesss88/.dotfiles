# Load Mcfly
export MCFLY_FUZZY=true
export MCFLY_RESULTS=20
export MCFLY_INTERFACE_VIEW=BOTTOM
export MCFLY_RESULTS_SORT=LAST_RUN
# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

eval "$(mcfly init zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
