# defaults programs
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export TERMINAL=/usr/bin/gnome-terminal

# https://wiki.archlinux.org/title/qt#Configuration_of_Qt_5_applications_under_environments_other_than_KDE_Plasma
export QT_QPA_PLATFORMTHEME="qt5ct"

# Java env vars
export JAVA_HOME=/usr/lib/jvm/default
export JRE_HOME=/usr/lib/jvm/default-runtime

# groff env vars
export GROFF_ENCODING=utf-8
export GROFF_TYPESETTER=pdf

# less options (no history, syntax highlighting)
export LESSHISTFILE=/dev/null
export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
export LESS=' -R '
# https://unix.stackexchange.com/questions/119/colors-in-man-pages/147#147
export GROFF_NO_SGR=1


# sanity
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Spring clean your $HOME (~/, that is)
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv/cuda"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtkrc-2.0"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export STACK_XDG=1
export W3M_DIR="$XDG_STATE_HOME/w3m"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"

# (Neo)Vim init
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'
