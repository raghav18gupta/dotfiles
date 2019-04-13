# Some useful services
sudo pacman -S acpid ntp dbus avahi cups cronie
sudo systemctl enable acpid
sudo systemctl enable ntpd
sudo systemctl enable avahi-daemon
sudo systemctl enable org.cups.cupsd.service


# Drivers
sudo pacman -S xorg-drivers xf86-input-synaptics xf86-video-intel


# Minimal gnome installation
sudo pacman -S gnome-shell gnome-terminal gnome-tweak-tool gnome-control-center xdg-user-dirs


# Gnome-keyring is needed to store the wifi passwords encrypted
sudo pacman -S networkmanager gnome-keyring
sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager
