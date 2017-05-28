# Set up the prompt

autoload -Uz colors && colors

autoload -Uz promptinit && promptinit

# Use modern completion system
autoload -Uz compinit && compinit

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v

autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
PROMPT="%~ (´・ω・｀) %v
"

function zle-line-init zle-keymap-select {
    VIM_NORMAL="%K{208}%F{black} %k%f%K{208}%F{white} % NORMAL %k%f%K{black}%F{208} %k%f"
    VIM_INSERT="%K{075}%F{black} %k%f%K{075}%F{white} % INSERT %k%f%K{black}%F{075} %k%f"
    RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M viins 'jj' vi-cmd-mode

alias ls='ls -G'
alias la='ls -a -G'
alias vim='nvim'

export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim

