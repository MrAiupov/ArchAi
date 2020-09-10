echo '1.0 Настраиваем, монтируем, и входим в Arch-Chroot'
genfstab -pU /mnt >> /mnt/etc/fstab
arch-chroot /mnt sh -c "$(curl -fsSL git.io/ссылка)"

echo '1.1 Устанавливаем временную зону'
ln -svf /usr/share/zoneinfo/Europe/Moscow /etc/localtime /etc/localtime

echo '1.2.1 Добавляем русскую локаль системы'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen 

echo '1.2.2 Обновляем текущую локаль системы'
locale-gen

echo '1.2.3 Указываем язык системы'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf

echo '1.2.4 Вписываем KEYMAP=ru FONT=cyr-sun16'
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

echo '1.3 Создадаём загрузочный RAM диск'
mkinitcpio -p linux

echo '1.4.1 Устанавливаем загрузчик для GPT'
pacman -Syy
pacman -S grub efibootmgr os-prober grub-customizer --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

echo '1.4.2 Обновляем grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg

echo '1.5.1 Прописываем имя компьютера и пользователя'
read -p "Введите имя компьютера: " hostname
read -p "Введите имя пользователя: " username
echo $hostname > /etc/hostname
useradd -m -g users -G wheel -s /bin/bash $username

echo '1.5.2 Создаем root пароль'
passwd

echo '1.5.3 Устанавливаем пароль пользователя'
passwd $username

echo '1.5.4 Устанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

echo '1.6 Раскомментируем репозиторий multilib Для работы 32-битных приложений в 64-битной системе.'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syy

echo '1.7.1 Устанавливаем xorg и драйвера для него'
pacman -S xorg-server xorg-drivers xorg-xinit --noconfirm 

echo '1.7.2 Устанавливаем дополнительные шрифты'
pacman -S ttf-liberation ttf-dejavu wqy-zenhei --noconfirm 

echo '1.7.3 Устанавливаем программы и драйвера для сети и Wi-Fi'
pacman -S networkmanager network-manager-applet ppp dialog wpa_supplicant broadcom-wl --noconfirm

echo '1.7.4 Устанавливаем поддержку ntfc формата'
pacman -S ntfs-3g ufw --noconfirm

echo '1.7.5 Установка аудиодрайверов'
pacman -S alsa-lib alsa-utils --noconfirm

echo "1.8.1 Установить KDE Plasma?"
read -p "1 - Да, 0 - Нет: " vm_setting
if [[ $vm_setting == 0 ]]; then
  kde_install="gparted gnome-disk-utility screenfetch --noconfirm"
elif [[ $vm_setting == 1 ]]; then
  kde_install="plasma kdebase sddm sddm-kcm dolphin ark kate spectacle kcalc okular gnome-disk-utility gparted gwenview kde-gtk-config user-manager screenfetch --noconfirm"
fi
echo 'Ставим иксы и драйвера'
pacman -S $kde_install

echo "1.8.2 Установить дополнительные программы?"
echo "(chromium firefox firefox-i18n-ru opera opera-ffmpeg-codecs vlc elisa gimp krita kdenlive libreoffice libreoffice-fresh-ru obs-studio audacity qbittorrent inkscape handbrake)"
read -p "1 - Да, 0 - Нет: " vm_setting
if [[ $vm_setting == 0 ]]; then
  prog_install="pacman -Syy"
elif [[ $vm_setting == 1 ]]; then
  prog_install="pacman -S chromium firefox firefox-i18n-ru opera opera-ffmpeg-codecs vlc elisa gimp krita kdenlive libreoffice libreoffice-fresh-ru obs-studio audacity qbittorrent inkscape handbrake --noconfirm"
fi
echo 'Установка дополнительный программ'
$prog_install

echo '1.9.1 Подключаем автозагрузку менеджера входа и интернет'
systemctl enable NetworkManager

echo "1.9.2 Включить SDDM в автозагрузку?"
read -p "1 - Да, 0 - Нет: " vm_setting
if [[ $vm_setting == 0 ]]; then
  sddm_install="reboot"
elif [[ $vm_setting == 1 ]]; then
  sddm_install="enable sddm"
fi
echo 'Включить SDDM в автозагрузку?'
systemctl $sddm_install

echo '2.0 Установка завершена! Перезагрузите систему.'
exit
