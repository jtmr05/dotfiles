# files

CONFIG_FILES 	:=\
	.config/VSCodium/User/settings.json\
	.config/clipit\
	.config/dir_colors\
	.config/dunst\
	.config/flameshot\
	.config/fontconfig\
	.config/gdb\
	.config/git\
	.config/gtk-3.0\
	.config/gtkrc-2.0\
	.config/htop\
	.config/i3\
	.config/latexmk\
	.config/mimeapps.list\
	.config/mpv\
	.config/nano\
	.config/neofetch\
	.config/nitrogen\
	.config/npm\
	.config/nvim/init.lua\
	.config/p10k.zsh\
	.config/pavucontrol.ini\
	.config/picom.conf\
	.config/polybar\
	.config/protonvpn\
	.config/pycodestyle\
	.config/qt5ct\
	.config/qt6ct\
	.config/ranger\
	.config/remaps\
	.config/rofi\
	.config/user-dirs.dirs\
	.config/user-dirs.locale\
	.config/vlc\
	.config/wgetrc\
	.config/ycm_extra_conf.py\
	.config/zathura\
	.config/zsh\
	.ghci\
	.profile\
	.vimrc\
	.zshrc


SCRIPTS			:=\
	.local/bin/checksum\
	.local/bin/csv2json\
	.local/bin/ipynb2py\
	.local/bin/my-blurlock\
	.local/bin/my-i3exit\
	.local/bin/my-init-picom\
	.local/bin/my-init-polybar\
	.local/bin/my-init-protonvpn\
	.local/bin/my-toggle-touchpad\
	.local/bin/my-volume-mixer\
	.local/bin/ncspot_build\
	.local/bin/normfn\
	.local/bin/silent


# make default goal (using make with no specified recipe)
.DEFAULT_GOAL := sync

sync: $(CONFIG_FILES) $(SCRIPTS) gnome-terminal

$(CONFIG_FILES): % : ${HOME}/%
	@mkdir -p $(@D)
	cp -r $< $(@D)

$(SCRIPTS): % : ${HOME}/%
	@mkdir -p $(@D)
	cp -r $< $(@D)

# https://askubuntu.com/questions/774394/wheres-the-gnome-terminal-config-file-located
.PHONY: gnome-terminal
gnome-terminal:
	dconf dump /org/gnome/terminal/ > gterminal.preferences
