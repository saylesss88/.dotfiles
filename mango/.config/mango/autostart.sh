#!/bin/bash
echo "autostart ran at $(date)" >> /tmp/mango-autostart.log

set +e

# some env can't auto run the portal, so need this
/usr/lib/xdg-desktop-portal-wlr  >/dev/null 2>&1 &

# notify
# swaync -c ~/.config/mango/swaync/config.jsonc -s ~/.config/mango/swaync/style.css >/dev/null 2>&1 &

# top bar
# waybar -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css >/dev/null 2>&1 &w
waybar 2>&1 &

# night light
wlsunset -T 3501 -t 3500 >/dev/null 2>&1 &

# wallpaper
swaybg -i ~/.config/mango/wallpapers/original-anime-cafe.jpg >/dev/null 2>&1 &



# xwayland dpi scale
# echo "Xft.dpi: 140" | xrdb -merge #dpi缩放
# xrdb merge ~/.Xresources >/dev/null 2>&1

# ime input
# fcitx5 --replace -d >/dev/null 2>&1 &

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &

# clipboard content manager
wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

# bluetooth 
blueman-applet >/dev/null 2>&1 &

# network
nm-applet >/dev/null 2>&1 &

# Permission authentication
/usr/lib/xfce-polkit/xfce-polkit >/dev/null 2>&1 &


# Start the keyring daemon
/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh >/dev/null 2>&1 &

# inhibit by audio
sway-audio-idle-inhibit >/dev/null 2>&1 &

# change light value and volume value by swayosd-client in keybind
# swayosd-server >/dev/null 2>&1 &
