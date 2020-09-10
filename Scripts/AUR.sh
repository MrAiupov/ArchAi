echo 'wget git.io/JUWf6 && sh JUWf6'
echo 'Включение AUR репозитория'
sudo pacman -Syu
mkdir -p /tmp/yay_install
cd /tmp/yay_install
sudo pacman -S git --noconfirm
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -sir --needed --noconfirm --skippgpcheck
cd ..
cd ..
rm -rf yay_install
cd ..
