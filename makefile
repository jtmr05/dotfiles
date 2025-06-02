# files

CONFIG_FILES :=\
	.config/alacritty/alacritty.toml\
	.config/btop/btop.conf\
	.config/clipit\
	.config/dir_colors\
	.config/dunst\
	.config/fastfetch/config.jsonc\
	.config/flameshot\
	.config/fontconfig\
	.config/gdb\
	.config/ghc/ghci.conf\
	.config/git\
	.config/gtk-3.0\
	.config/gtkrc-2.0\
	.config/i3\
	.config/latexmk\
	.config/mimeapps.list\
	.config/mpv\
	.config/nano\
	.config/nitrogen\
	.config/npm\
	.config/nvim/init.lua\
	.config/p10k.zsh\
	.config/pavucontrol.ini\
	.config/picom.conf\
	.config/polybar\
	.config/pycodestyle\
	.config/qt5ct\
	.config/qt6ct\
	.config/ranger\
	.config/remaps\
	.config/rofi\
	.config/user-dirs.dirs\
	.config/user-dirs.locale\
	.config/vim/vimrc\
	.config/vlc\
	.config/wgetrc\
	.config/ycm_extra_conf.py\
	.config/zathura\
	.config/zsh/.zprofile\
	.config/zsh/.zshrc\
	.profile

SCRIPTS :=\
	.local/bin/cell2script\
	.local/bin/csv2json\
	.local/bin/ipynb2py\
	.local/bin/my-blurlock\
	.local/bin/my-i3exit\
	.local/bin/my-init-picom\
	.local/bin/my-init-polybar\
	.local/bin/my-toggle-touchpad\
	.local/bin/my-volume-mixer\
	.local/bin/normfn\
	.local/bin/silent


# make default goal (using make with no specified recipe)
.DEFAULT_GOAL := sync

sync: $(CONFIG_FILES) $(SCRIPTS)

$(CONFIG_FILES): % : ${HOME}/%
	@mkdir -p $(@D)
	cp -r $< $(@D)

$(SCRIPTS): % : ${HOME}/%
	@mkdir -p $(@D)
	cp -r $< $(@D)
