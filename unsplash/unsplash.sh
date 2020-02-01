#!/bin/bash

wget -O /tmp/wallpaper-temp.jpg https://source.unsplash.com/1600x900

if [ $? -eq 0 ]; then
    mv /tmp/wallpaper-temp.jpg /tmp/wallpaper.jpg
    gsettings set org.gnome.desktop.background picture-uri file:///tmp/wallpaper.jpg
    gsettings set org.gnome.desktop.screensaver picture-uri file:///tmp/wallpaper.jpg
fi
