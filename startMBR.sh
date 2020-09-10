#!/bin/bash
# Arch Auto install
# Скрипт быстрой установки Arch Linux

echo '0.1 Настройка шрифта, клавиатуры и синхронизация системных часов'
timedatectl set-ntp true
loadkeys ru
setfont cyr-sun16

echo '0.2 Создание разделов'
(
  echo o;

  echo n;
  echo;
  echo;
  echo;
  echo +4096M;

  echo n;
  echo p;
  echo;
  echo;
  echo a;
  echo 1;

  echo w;
) | fdisk /dev/sda

echo '0.3.1 Форматирование разделов'
mkswap /dev/sda1
mkfs.ext4 /dev/sda2

echo '0.3.2 Создание и монтирование дисков'
mount /dev/sda2 /mnt
swapon /dev/sda1

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
