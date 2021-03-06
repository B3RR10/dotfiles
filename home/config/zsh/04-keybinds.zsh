# Vim mode {{{ #
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey '^o' vi-cmd-mode
bindkey '^[' vi-cmd-mode

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Edit line in vim with `V` in normal mode:
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'V' edit-command-line
# }}} Vim mode #

# Use c-z to toggle fg and bg
fancy-ctrl-z () {
  emulate -R zsh
  if [[ $#BUFFER -eq 0 && -n $(jobs) ]]; then
    fg
    zle redisplay
  else
    zle push-input
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# vim: foldmethod=marker
