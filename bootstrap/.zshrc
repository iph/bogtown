eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"

export PATH=$PATH:/Users/seamyers/.cargo/bin
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
