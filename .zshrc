# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
    source /usr/share/zsh/manjaro-zsh-config
fi

# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
    source /usr/share/zsh/manjaro-zsh-prompt
fi

# dircolors
[ -f "$XDG_CONFIG_HOME/dir_colors" ] && eval $(dircolors -b "$XDG_CONFIG_HOME/dir_colors")

# aliases
[ -f "$XDG_CONFIG_HOME/zsh/aliases.zsh" ] && source "$XDG_CONFIG_HOME/zsh/aliases.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ -f "$XDG_CONFIG_HOME/p10k.zsh" ] && source "$XDG_CONFIG_HOME/p10k.zsh"

# disabling zsh autocd is recommended
unsetopt autocd

# disable corrections and suggestions
unsetopt correct
unsetopt correct_all

# vi mode (buggy af)
bindkey -v
