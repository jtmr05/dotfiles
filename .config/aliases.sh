# get name of current shell (bash or zsh)
_ALIASES_SHELL=${_ALIASES_SHELL:-$(ps -p "$$" -o 'comm=')}
if [ "$_ALIASES_SHELL" = 'zsh' ]; then
    _RCFILE="$ZDOTDIR/.zshrc"
elif [ "$_ALIASES_SHELL" = 'bash' ]; then
    _RCFILE="$HOME/.bashrc"
fi

# cd utilities
alias bcd='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

# ls aliases
alias ls='/usr/bin/ls --color=auto --group-directories-first -h'
alias la='ls -A'
alias ll='ls -lX'
alias lla='ll -A'
alias lal='lla'

# grep aliases
alias grep='\grep --color=auto'
alias grepl='\grep -P --color=auto'

# quick vim-like command options
alias :r='. "$_RCFILE"'
alias :e='vim "$_RCFILE"'
alias :a='vim "$XDG_CONFIG_HOME/aliases.sh"'
alias :q='exit'
alias :vrc='vim "$XDG_CONFIG_HOME/vim/vimrc"'

# make sudo work with aliases
alias sudo='sudo '

# pacman/AUR aliases
alias pacd="expac -Q --timefmt='%Y-%m-%d %T' '%l\t%w\t%n' | grep '[[:blank:]]explicit' | sort"
alias pacrm='pacman -Qqdt | sudo pacman -Rn -'
alias sh='env HISTFILE=/dev/null sh'
alias syu='trizen -Syu'
alias trizenrm='trizen -Qqdt | trizen -Rn -'

# others
alias alb='vim "$HOME/docs/albums.yml"'
alias cp='cp -v'
alias df='df -h'
alias free='free -m'
alias mv='mv -v'
alias nv='nvim'
alias perl='perl -W'
alias posixcheck='shellcheck -s sh'
alias venv='python3 -m venv'

# perldoc to man
# perldoc -u -T <page> | pod2man | man -l /dev/stdin
#
# man page to pdf
# man -Tpdf <page> | zathura -
#
# perldoc to pdf
# perldoc -u -T <page> |pod2man | man -Tpdf -l /dev/stdin | zathura -

# open a new terminal in the CWD
dup(){
    silent alacritty --working-directory="'$PWD'"
}

# fuzzy find a subdirectory of DIR and cd into it
zcd(){

    _FUNC_NAME="$0"

    _usage(){
        echo "Usage: $_FUNC_NAME: [OPTION]... [--] [DIR]"
        echo 'Fuzzy find a subdirectory of DIR and cd into it.'
        echo 'If DIR is omitted, the current working directory is used instead.'
        echo ''
        echo 'Available options:'
        echo '  -f      do not read from cached history files'
        echo '  -h      print this message and exit'
        echo '  -z      filter out hidden directories'
    }

    _try(){
        echo "Try '$_FUNC_NAME -h' for more information" > /dev/stderr
    }

    # load array manipulation utility functions
    . "$HOME/.local/lib/array.sh"

    # options
    _fresh=0
    _hidden=1

    _index=1; while [ "$_index" -le $# ]; do

        _elem="$(eval "$(array_index "$_index")")"
        case "$_elem" in
            '-')
                echo "$_FUNC_NAME: warning: single dash ignored" > /dev/stderr
                eval "$(array_remove "$_index" "$@")"
                ;;
            -*)
                eval "$(array_remove "$_index" "$@")"
                _opts="${_elem#-}"

                while [ -n "$_opts" ]; do
                    _opt=$(printf '%c' "$_opts")
                    case "$_opt" in
                        'f')
                            _fresh=1
                            ;;
                        'h')
                            _usage
                            return 0
                            ;;
                        'z')
                            _hidden=0
                            ;;
                        '-')
                            break 2
                            ;;
                        *)
                            echo "$_FUNC_NAME: '-$_opt': unrecognized option" > /dev/stderr
                            _try
                            return 1
                            ;;
                    esac
                    _opts="${_opts#"$_opt"}"
                done
                ;;
            *)
                _index=$((_index+1))
                ;;
        esac
    done

    if [ $# -gt 1 ]; then
        echo "$_FUNC_NAME: '$2': extra operand" > /dev/stderr
        _try
        return 1
    fi

    # use current working directory if no argument given
    _dir="${1:-$PWD}"

    if ! [ -e "$_dir" ]; then
        echo "$_FUNC_NAME: '$_dir': no such file or directory" > /dev/stderr
        return 2
    elif ! [ -d "$_dir" ]; then
        echo "$_FUNC_NAME: '$_dir': not a directory" > /dev/stderr
        return 2
    fi

    # resolve _dir into an absolute path
    # FIXME
    # case "$_dir" in
    #     /*)
    #         ;;
    #     *)
    #         _dir="$PWD/$_dir"
    # esac

    _dir=$(perl -MCwd -E 'say Cwd::realpath($ARGV[0])' -- "$_dir")

    # store history files in XDG cache dir
    XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.local/cache}"
    _cache_dir="$XDG_CACHE_HOME/$_FUNC_NAME"
    mkdir -p "$_cache_dir"

    # perform a hash on the given dir path
    _histfile_name="$_cache_dir/$(echo "$_hidden$_dir" | cksum | cut -d ' ' -f 1)"
    [ "$_fresh" -eq 1 ] && rm -f "$_histfile_name"

    if [ -f "$_histfile_name" ]; then
        _source_list(){
            < "$_histfile_name"
        }
    elif [ "$_hidden" -eq 1 ]; then
        # want to show hidden directories
        _source_list(){
            find "$1" -type d 2> /dev/null |
            tee "$_histfile_name"
        }
    else
        # hide hidden directories
        _source_list(){
            find "$1" -type d ! -path '*/.*' 2> /dev/null |
            tee "$_histfile_name"
        }
    fi

    if _d=$(\
        _source_list "$_dir" |
        fzf --preview "ls --group-directories-first --color -lAXh {} 2> /dev/null"
    ); then
        cd "$_d" 2> /dev/null || { echo "$_FUNC_NAME: '$_d': cd failed" > /dev/stderr; return 3; }
    else
        echo "$_FUNC_NAME: no entry selected" > /dev/stderr
        return 4
    fi
}
