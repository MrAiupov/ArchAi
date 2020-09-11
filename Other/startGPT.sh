#!/bin/bash
# Arch Auto install
# Скрипт быстрой установки Arch Linux
# wget git.io/JUWDX && sh JUWDX

echo '0.1 Настройка шрифта, клавиатуры и синхронизация системных часов'
timedatectl set-ntp true
loadkeys ru
setfont cyr-sun16

echo '0.2 Создание разделов '
(
 echo g;

 echo n;
 echo ;
 echo;
 echo +1024M;
 echo;
 echo t;
 echo 1;

 echo n;
 echo;
 echo;
 echo +4096M;
 echo;
 
  
 echo n;
 echo;
 echo;
 echo;
 echo;
  
 echo w;
) | fdisk /dev/sda

echo '0.3.1 Форматирование разделов'
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3

echo '0.3.2 Создание и монтирование дисков.'
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda2
mkdir /mnt/hard1
mount /dev/sdb1 /mnt/hard1

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
arch-chroot /mnt sh -c "$(curl -fsSL git.io/JUWDr)"
