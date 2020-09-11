# wget git.io/JUWf6 && sh JUWf6
echo 'Включение AUR репозитория'
sudo pacman -Syu
mkdir -p /tmp/yay_install
cd /tmp/yay_install
sudo pacman -S wget git curl --noconfirm
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --skipinteg
cd ..
cd ..
rm -rf yay_install
cd ..
