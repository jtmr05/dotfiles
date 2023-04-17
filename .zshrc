# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

source ~/.zsh_aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export XDG_CONFIG_HOME=~/.config

# Java env vars
export JAVA_HOME=/usr/lib/jvm/default
export JRE_HOME=/usr/lib/jvm/default-runtime

# groff env vars
export GROFF_ENCODING=utf-8
export GROFF_TYPESETTER=pdf

# disable less command history
export LESSHISTFILE=/dev/null

# syntax highlight less
export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
export LESS=' -R '

# disabling zsh autocd is recommended
unsetopt autocd

# disable corrections and suggestions
unsetopt correct
unsetopt correct_all

# vi mode (buggy af)
# bindkey -v
