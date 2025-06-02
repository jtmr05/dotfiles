# options

# immediately append history instead of overwriting
setopt appendhistory
# FIXME share history across multiple instances of zsh
setopt incappendhistorytime
# don't save commands starting with space to history file
setopt histignorespace
# extended globbing - allows using regular expressions with *
setopt extendedglob
# if a new command is a duplicate, remove the older one
setopt histignorealldups
# don't save commands that start with space
setopt histignorespace
# save commands are added to the history immediately
setopt inc_append_history
# no beep
setopt nobeep
# case insensitive globbing
setopt nocaseglob
# sort filenames numerically when it makes sense
setopt numericglobsort

# case insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
# colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# automatically find new executables in path
zstyle ':completion:*' rehash true
# highlight menu selection
zstyle ':completion:*' menu select

# speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh"

HISTFILE="$XDG_STATE_HOME/zsh/history"
HIST_SAVE_NO_DUPS=erase
HISTSIZE=10000
SAVEHIST=$HISTSIZE

# don't consider certain characters part of the word
WORDCHARS=${WORDCHARS//\/[&.;]}


# keybindings section

# Home key
bindkey '^[[7~' beginning-of-line
bindkey '^[[H' beginning-of-line
# End key
bindkey '^[[8~' end-of-line
bindkey '^[[F' end-of-line

bindkey '^[[2~' overwrite-mode
bindkey '^[[3~' delete-char
bindkey '^[[C'  forward-char
bindkey '^[[D'  backward-char
bindkey '^[[5~' history-beginning-search-backward
bindkey '^[[6~' history-beginning-search-forward

# navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word
bindkey '^[Od' backward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
# delete previous word with ctrl+backspace
bindkey '^H' backward-kill-word

# Theming section
autoload -U compinit colors zcalc
compinit -d
colors

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'


# plugins

# use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# powerlevel10k prompt
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# bind j and k arrow keys to history substring search in vim normal mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# accept suggestion with Ctrl-a
bindkey '^a' autosuggest-accept
bindkey -M vicmd '^a' autosuggest-accept


# load aliases
[ -f "$XDG_CONFIG_HOME/aliases.sh" ] && source "$XDG_CONFIG_HOME/aliases.sh"

# to customize prompt, run `p10k configure` or edit "$XDG_CONFIG_HOME/p10k.zsh".
[ -f "$XDG_CONFIG_HOME/p10k.zsh" ] && source "$XDG_CONFIG_HOME/p10k.zsh"


# vi mode
bindkey -v

# change to normal vi mode faster (in hundredths of second)
KEYTIMEOUT=2

# block cursor normal mode/ibeam insert mode
# https://old.reddit.com/r/vim/comments/mxhcl4/setting_cursor_indicator_for_zshvi_mode_in/
zle-keymap-select(){
    case "$KEYMAP" in
        vicmd)
            echo -ne '\e[1 q' # block
            ;;
        viins|main)
            echo -ne '\e[5 q' # beam
            ;;
    esac
}
zle -N zle-keymap-select

zle-line-init(){
    echo -ne '\e[5 q'
}
zle -N zle-line-init

vi-yank-xclip(){
    zle vi-yank
    echo "$CUTBUFFER" | xclip -selection clipboard
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

vi-paste-xclip(){
    CUTBUFFER="$(xclip -o -selection clipboard)"
    zle vi-put-before
}
vi-paste-xclip-after(){
    CUTBUFFER="$(xclip -o -selection clipboard)"
    zle vi-put-after
}
zle -N vi-paste-xclip
bindkey -M vicmd 'P' vi-paste-xclip
zle -N vi-paste-xclip-after
bindkey -M vicmd 'p' vi-paste-xclip-after

# fzf integration
eval "$(fzf --zsh)"

# linux user moment
fastfetch
