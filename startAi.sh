#!/bin/bash
# Arch Auto install
# Скрипт быстрой установки Arch Linux

echo '0.1 Настройка шрифта, клавиатуры и синхронизация системных часов'
timedatectl set-ntp true
loadkeys ru
setfont cyr-sun16

echo "0.2 Установка производится на диск с разметкой GPT или MBR?"
read -p "1 - GPT, 0 - MBR: " vm_setting
if [[ $vm_setting == 0 ]]; then
  disk_install="wget git.io/JUWeC && sh JUWeC"
elif [[ $vm_setting == 1 ]]; then
  disk_install="wget git.io/JUWem && sh JUWem"
fi
echo 'Установка производится на диск с разметкой GPT или MBR?'
$disk_install

echo '0.4 Выбор зеркал России для загрузки.'
echo "##" > /etc/pacman.d/mirrorlist
echo "##Arch Linux repository mirrorlist" >> /etc/pacman.d/mirrorlist
echo "##Generated on 2020-02-19" >> /etc/pacman.d/mirrorlist
echo "##" >> /etc/pacman.d/mirrorlist
echo "##Russia" >> /etc/pacman.d/mirrorlist
echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
echo "Server = https://mirror.yandex.ru/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
echo "Server = http://mirror.truenetwork.ru/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
echo "Server = http://mirror.rol.ru/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
echo "Server = https://mirror.rol.ru/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
echo "Server = http://archlinux.zepto.cloud/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist

echo '0.5 Устанавливаем Arch Linux и основныe базовые пакетов'
pacstrap /mnt base base-devel linux linux-firmware nano dhcpcd netctl

echo '1.0 Настраиваем, монтируем, и входим в Arch-Chroot'
genfstab -pU /mnt >> /mnt/etc/fstab
arch-chroot /mnt sh -c "$(curl -fsSL git.io/JUWew)"
