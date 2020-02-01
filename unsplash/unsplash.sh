#!/bin/bash

wget -O /bin/unsplash/temp-wallpaper.jpg https://source.unsplash.com/1600x900

if [ $? -eq 0 ]; then
    cp /bin/unsplash/temp-wallpaper.jpg /bin/unsplash/wallpaper.jpg
    gsettings set org.gnome.desktop.background picture-uri /bin/unsplash/wallpaper.jpg
    gsettings set org.gnome.desktop.screensaver picture-uri /bin/unsplash/wallpaper.jpg
fi