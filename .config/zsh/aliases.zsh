function my_unalias(){
    alias $1 > /dev/null && unalias $1
}

function my_unset(){
    typeset -f $1 > /dev/null && unset -f $1
}

# Manjaro options alias this...
my_unalias cp

# cd utilities
my_unset better_cd
my_unset bcd

function better_cd(){
    CURR_PWD=$PWD
    \cd $1 && export OLD_PWD=$CURR_PWD && unset CURR_PWD && return 0
    unset CURR_PWD
    return 1
}

function bcd(){
    CURR_PWD=$PWD
    \cd $OLD_PWD && export OLD_PWD=$CURR_PWD && unset CURR_PWD && return 0
    unset CURR_PWD
    return 1
}

alias cd='better_cd'
alias ..='better_cd ..'
alias ...='better_cd ../..'
alias ....='better_cd ../../..'
alias .....='better_cd ../../../..'
alias ......='better_cd ../../../../..'

alias thesis='cd ~/docs/5ano/thesis'
alias pei='cd ~/docs/5ano/pei'
alias daa='cd ~/docs/4ano/1sem/DAAv2'

# some utility commands
alias cl='clear'

# https://stackoverflow.com/questions/24843614/execute-process-in-background-without-printing-done-and-get-pid
# open a new terminal in the same CWD
function dup(){
    { gnome-terminal --working-directory=$PWD 2>&3 & disown; } 2> /dev/null 3>&2
}


# ls aliases
alias ls='\ls --color=auto --group-directories-first -h'
alias la='ls -A'
alias ll='ls -lX'
alias lla='ll -A'
alias lal='lla'

# grep aliases
alias grep='\grep --color=auto'
alias grepl='\grep -P --color=auto'

# quick vim-like command options
alias :r="source $HOME/.zshrc"
alias :e="vim $HOME/.zshrc"
alias :a="vim $XDG_CONFIG_HOME/zsh/aliases.zsh"
alias :q='exit'

# vim aliases
alias :vrc="vim $HOME/.config/vim/vimrc"
alias v='vim'


# other utilities
alias alb="vim $HOME/docs/albums.txt"

alias venv='python3 -m venv'

alias pacrm='pacman -Qqdt | sudo pacman -Rns -'
alias trizenrm='trizen -Qqdt | trizen -Rns -'
alias pacd="expac -Q --timefmt='%Y-%m-%d %T' '%l\t%w\t%n' | grepl --color=never '\texplicit\t'| sort"
# TODO make this a script
alias trizencc=$'ls -1 ~/.cache/trizen/sources | perl -w -nE \'chomp;\
    if(system "pacman -Qi $_ > /dev/null 2> /dev/null"){ system "rm -rf $_"; }\''

alias nv='nvim'
