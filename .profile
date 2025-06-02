prepend_path(){
    case ":$PATH:" in
        *":$1:"*)
            ;;
        *":$1/:"*)
            ;;
        *)
            PATH="$1${PATH:+:$PATH}"
            ;;
    esac
}

append_path(){
    case ":$PATH:" in
        *":$1:"*)
            ;;
        *":$1/:"*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
            ;;
    esac
}

prepend_path "$HOME/.local/bin"
append_path  "$HOME/.local/bin/games"
unset -f prepend_path append_path
export PATH


# sanity
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"


prepend_data_dir(){
    case ":$XDG_DATA_DIRS:" in
        *":$1:"*)
            ;;
        *":$1/:"*)
            ;;
        *)
            XDG_DATA_DIRS="$1${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
            ;;
    esac
}

prepend_data_dir '/usr/local/share'
prepend_data_dir '/usr/share'
prepend_data_dir "$XDG_DATA_HOME"
unset -f prepend_data_dir
export XDG_DATA_DIRS


# default programs
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less
export VISUAL=/usr/bin/vim
# RIP Firefox (2004-2025)
# export BROWSER=/usr/bin/firefox
export BROWSER=/usr/bin/librewolf
export TERMINAL=/usr/bin/alacritty

# https://wiki.archlinux.org/title/qt#Configuration_of_Qt_5_applications_under_environments_other_than_KDE_Plasma
export QT_QPA_PLATFORMTHEME="qt5ct"

# Java env vars
export JAVA_HOME=/usr/lib/jvm/default
export JRE_HOME=/usr/lib/jvm/default-runtime

# groff env vars
export GROFF_ENCODING=utf-8
export GROFF_TYPESETTER=pdf

# https://unix.stackexchange.com/questions/119/colors-in-man-pages/147#147
export GROFF_NO_SGR=1

# less options (no history, syntax highlighting)
export LESSHISTFILE=/dev/null
export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
export LESS='-i -R'

# perldoc options
export PERLDOC='-M Pod::Text::Color'
export PERLDOC_PAGER='less'

# fix alacritty small size
# https://wiki.archlinux.org/title/Alacritty#Different_font_size_on_multiple_monitors
export WINIT_X11_SCALE_FACTOR=1.5

# Spring clean your $HOME (~/, that is)
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv/cuda"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtkrc-2.0"
export JUPYTER_PLATFORM_DIRS="1"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export STACK_XDG=1
export W3M_DIR="$XDG_STATE_HOME/w3m"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XCURSOR_PATH="$XDG_DATA_HOME/icons:/usr/share/icons"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"

# (Neo)Vim init
export VIMINIT="let \$MYVIMRC = !has('nvim') ? '$XDG_CONFIG_HOME/vim/vimrc' : '$XDG_CONFIG_HOME/nvim/init.vim' | so \$MYVIMRC"

# so that startx knows where to look for xinitrc
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

# dircolors
[ -f "$XDG_CONFIG_HOME/dir_colors" ] && eval "$(dircolors -b "$XDG_CONFIG_HOME/dir_colors")"

# bash doesn't automatically source ~/.bashrc when used as an interactive login shell
# zsh does it automatically
if [ "$(ps -p "$$" -o comm=)" = 'bash' ]; then
    case "$-" in
        *i*)
            [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
            ;;
    esac
fi

# include startx here
# exec startx
