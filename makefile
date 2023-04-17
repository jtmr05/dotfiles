# files
CONFIG_FILES 	:=\
	.dir_colors\
	.gdbinit\
	.ghci\
	.gitconfig\
	.nanorc\
	.vimrc\
	.ycm_extra_conf.py\
	.zsh_aliases\
	.zshrc\
	.config/dunst\
	.config/flameshot\
	.config/fontconfig\
	.config/htop\
	.config/i3\
	.config/ncspot/config.toml\
	.config/nitrogen\
	.config/polybar\
	.config/pycodestyle\
	.config/rofi\
	.config/zathura

SCRIPTS			:=\
	.local/bin/my_blurlock\
	.local/bin/my_i3exit\
	.local/bin/my_init_picom\
	.local/bin/my_init_polybar\
	.local/bin/my_init_protonvpn\
	.local/bin/my_toggle_touchpad\
	.local/bin/my_volume_mixer


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
