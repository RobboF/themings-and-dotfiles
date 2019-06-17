#!/bin/bash

# Update
sudo pacman-key --init
sudo pacman-key --populate archlinux manjaro
sudo pacman-key --refresh-keys
sudo pacman -Syyu

# Theming
tar -xvf Sweet-Dark.tar.xz 
sudo cp -r Sweet-Dark /usr/share/themes/ || exit
gsettings set org.gnome.desktop.interface gtk-theme Sweet-Dark
gsettings set org.gnome.desktop.wm.preferences theme Sweet-Dark
## Icons
tar -xvf Sweet-Purple.tar.xz
cp -r Sweet-Purple /usr/share/icons/
gsettings set org.gnome.desktop.interface icon-theme 'Sweet-Purple'

# Installation
sudo pacman -S zsh zsh-completions alacritty code python-pip emacs-nox

# ColorScheme
sudo pip3 install pywal
wal -i cropped-2560-1440-984617.jpg

# Oh my zsh
sh -c $(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh::g' | sed 's/exec zsh -l//')
chsh -s /bin/zsh
sed -i '1i (cat ~/.cache/wal/sequences &)' $HOME/.zshrc
sed -i 's/ZSH_THEME=.*/ZSH_THEME="agnoster"/' $HOME/.zshrc
# Fonts
wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fura%20Code%20Regular%20Nerd%20Font%20Complete%20Mono.ttf?raw=true -P $HOME/.fonts -O fira-code.ttf
fc-cache
mkdir $HOME/.config/alacritty/
cp -f alacritty.yaml $HOME/.config/alacritty/

wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.otf -P $HOME/.fonts -O droid-sans.otf
fc-cache
gsettings set org.gnome.desktop.interface document-font-name 'DroidSansMono NF 10'
gsettings set org.gnome.desktop.interface font-name 'DroidSansMono NF 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'DroidSansMono NF 11'
gsettings set org.gnome.nautilus.desktop font 'DroidSansMono NF 10'
