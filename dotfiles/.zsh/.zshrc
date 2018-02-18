source ~/.zplug/init.zsh

[ -f $ZDOTDIR/.zshrc.`uname` ] && . $ZDOTDIR/.zshrc.`uname`
[ -f $ZDOTDIR/.zshrc.alias ] && . $ZDOTDIR/.zshrc.alias
[ -f $ZDOTDIR/.zshrc.export ] && . $ZDOTDIR/.zshrc.export

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

bindkey -e

zplug "zsh-users/zsh-completions"
zplug "joel-porquet/zsh-dircolors-solarized"
zplug "zsh-users/zsh-syntax-highlighting"
zplug load --verbose

setupsolarized dircolors.256dark

autoload -U compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

export RBENV_ROOT='${HOME}/.rbenv'
if [ -d '${RBENV_ROOT}' ]; then
    eval '$(rbenv init -)'
    export PATH='${RBENV_ROOT}/bin:${PATH}'
fi

eval "$(direnv hook zsh)"

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}!'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}+'
zstyle ':vcs_info:*' formats '%F{green}%c%u[%b]%f'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT='%n%#%{${fg[blue]}%}[%~]%{${reset_color}%}'
RPROMPT='${vcs_info_msg_0_}'
