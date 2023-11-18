eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"

export PATH=$PATH:/Users/seamyers/.cargo/bin
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
