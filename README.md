# Dot-Files

```
                   -`
                  .o+`
                 `ooo/
                `+oooo:
               `+oooooo:
               -+oooooo+:
             `/:-:++oooo+:
            `/++++/+++++++:
           `/++++++++++++++:
          `/+++ooooooooooooo/`
         ./ooosssso++osssssso+`
        .oossssso-````/ossssss+`
       -osssssso.      :ssssssso.
      :osssssss/        osssso+++.
     /ossssssss/        +ssssooo/-
   `/ossssso+/:-        -:/+osssso+-
  `+sso+:-`                 `.-/+oso:
 `++:.                           `-/+/
 .`                                 `/
```

## My ZSH rice

![neofetch](https://raw.githubusercontent.com/raghav18gupta/dotfiles/master/imgs/neofetch-ss.png)

## Packages I use:

- Fonts
	- `noto-fonts`
	- `noto-fonts-cjk`
	- `noto-fonts-emoji`
	- `noto-fonts-extra`
	- `ttf-dejavu`
	- `ttf-indic-otf`
	- `ttf-liberation`
	- `ttf-ubuntu-font-family`
	- `ttf-emojione` <sup><sup>*AUR*</sup></sup>

- Browsers
	- `chromium`
	- `firefox`
	- `tor-browser-en` <sup><sup>*AUR*</sup></sup>

- Eyecandy
	- `gnome`
	- `neofetch`
	- `chrome-gnome-shell`
	- `gnome-appfolders-manager` <sup><sup>*AUR*</sup></sup>

- Creativity
	- `dia`
	- `gimp`
	- `inkscape-git` <sup><sup>*AUR*</sup></sup>
	- `gravit-designer-bin` <sup><sup>*AUR*</sup></sup>

- CLI Tools
	- `zsh`
	- `git`
	- `vim`
	- `ranger`
	- `tree`
	- `bc`
	- `yay` <sup><sup>*AUR*</sup></sup>
	- `heroku-cli` <sup><sup>*AUR*</sup></sup>

- Programming Tools
	- `eclipse-java`
	- `pycharm-community-edition`
	- `sublime-text` <sup><sup>*[Sublime's Repo](https://www.sublimetext.com/docs/3/linux_repositories.html#pacman)*</sup></sup>

- Miscellaneous Tools
	- `filezilla`
	- `gparted`
	- `gnome-mpv`
	- `simplescreenrecorder`
	- `teamviewer` <sup><sup>*AUR*</sup></sup>
	- `realvnc-vnc-viewer` <sup><sup>*AUR*</sup></sup>
	- `wps-office` <sup><sup>*AUR*</sup></sup>
	- `transmission-gtk-git` <sup><sup>*AUR*</sup></sup>

- Remove these bloated package after installing above.
	- `totem`
	- `orca`
	- `gnome-getting-started-docs`
	- `gnome-user-docs`
	- `gnome-software`

- Not using for now:
	- `uget`
	- `gconf-editor`
	- `ntfs-3g`


## Configs:
- Themes
	- GTK3: [Flat Remix GTK Blue Darkest (solid & noBorder)](https://www.gnome-look.org/p/1214931/)
	- Shell : [Flat Remix Darkest (fullPanel)](https://www.gnome-look.org/p/1013030/)
	- Cursor : [Bibata Ice](https://www.gnome-look.org/p/1197198/)
	- Icons : [Paper](https://github.com/snwh/paper-icon-theme)

- GNOME Extentions
	- [Simple Net Speed](https://extensions.gnome.org/extension/1085/simple-net-speed/)
	- [Dash to panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)
	- [Desktop Icons](https://extensions.gnome.org/extension/1465/desktop-icons/)
	- [Remove Dropdown Arrows](https://extensions.gnome.org/extension/800/remove-dropdown-arrows/)
	- [User Themes](https://extensions.gnome.org/extension/19/user-themes/)

- Sublime Extentions
	- Anaconda
	- BracketHighlighter
	- GitGutter
	- Material Theme
	- Package Control
	- Side Bar

- Keyboard
	- `Tweaks> Keyboard and Mouse>Additional Layout options>Miscellaneous compatibility options>"Num Lock on: digits; Shift for arrow keys. Num Lock off: arrow keys (as in Windows)"`

- Git

	- `git config --global user.email "18raghavgupta@gmail.com"`
	- `git config --global user.name "raghav18gupta"`
	- `git config credential.helper store`
	- `git config --global credential.helper 'cache --timeout=9999999999999'`

- Swap File
	- `sudo fallocate -l 4G /swapfile`
	- `sudo chmod 600 /swapfile`
	- `sudo mkswap /swapfile`
	- `sudo swapon /swapfile`
	- Add lines to `/etc/fstab`:
		```
		# swap file
		/swapfile	swap	swap	defaults	0	0
		```
	- Check status: `sudo free -h`
	- Check swappiness: `cat /proc/sys/vm/swappiness`. Default is `60`.
	- Change swappiness: Add line `vm.swappiness=50` in `/etc/sysctl.conf`
	
## Conda Env: Project Dependencies
- [green-corridor](https://github.com/raghav18gupta/green-corridor-v2)
	- `pandas`
	- `firebase-admin`

- [news-feed](https://github.com/raghav18gupta/IndianExpressBot)
	- `telegram`
	- `telegraph`
	- `feedparser`
	- `beautifulsoup4`

- [naidunia](https://github.com/raghav18gupta/naidunia-epaper-downloder)
	- `telegram`
	- `PyPDF2`