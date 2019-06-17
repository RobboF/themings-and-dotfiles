#!/bin/bash

wget https://dl.opendesktop.org/api/files/download/id/1559753121/s/0d02da97adef73bed70c40e93ccc0c15da8388bf175d1843306e016fb0caa3c1ed376ab4b8e0fa94cc7da69f3790f1010d2d7f7127eb82b39f1b4fe49947ed46/t/1560034103/lt/download/Sweet-Dark.tar.xz
sudo pacman -S libconfig asciidoc alacritty python-pip rofi zsh --noconfirm
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh zsh
sed -i 's/ZSH_THEME=.*/ZSH_THEME="agnoster"/' ~/.config/alacritty/alacritty.yml
tar -xvf Sweet-Dark.tar.xz
sudo mv Sweet-Dark /usr/share/themes/
rm Sweet-Dark.tar.xz
xfconf-query -c xsettings -p /Net/ThemeName -s "Sweet-Dark"
xfconf-query -c xfwm4 -p /general/theme -s "Sweet-Dark"

############## Acquire Fonts #################
sudo mkdir -p /usr/share/fonts/TTF

sudo wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fura%20Code%20Regular%20Nerd%20Font%20Complete.ttf -P /usr/share/fonts/TTF

sudo wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fura%20Code%20Regular%20Nerd%20Font%2sudo 0Complete%20Mono.ttf -P /usr/share/fonts/TTF

sudo wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf -P /usr/share/fonts/TTF

fc-cache

################ Set Fonts ###################
xfconf-query -c xsettings -p /Gtk/FontName -s "DroidSansMono Nerd Font 10"
xfconf-query -c xfwm4 -p /general/title_font "DroidSansMono Nerd Font 11"

################ Wallpaper ###################
sudo pip3 install pywal
sudo cp cropped-2560-1440-984617.jpg /tmp/
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/last-image -s /tmp/cropped-2560-1440-984617.jpg

################## Icons #####################

git clone https://github.com/EliverLara/Sweet-folders
cd Sweet-folders
sudo mv Sweet-* /usr/share/icons
xfconf-query -c xsettings -p /Net/IconThemeName -s "Sweet-Purple"
cd .. && rm -rf Sweet-folders

############### compositor ##################
xfconf-query -c xfwm4 -p /general/use_compositing -s false
git clone https://github.com/tryone144/compton
cd compton && make && sudo make install
cd .. && rm -rf compton
xfconf-query --channel xfce4-keyboard-shortcuts --property "/commands/custom/<Super>space" --create --type string --set "rofi -show run"
cp compton.conf ~/.config/
compton --config ~/.config/compton.conf &
sed -i 's/background_opacity:.*/background_opacity: 0.8/' ~/.config/alacritty/alacritty.yml
