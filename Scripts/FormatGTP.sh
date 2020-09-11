#!/bin/bash

# wget git.io/JUWem && sh JUWem
echo 'Создание разделов '
(
 echo g;

 echo n;
 echo ;
 echo;
 echo +1024M;
 echo y;
 echo t;
 echo 1;

 echo n;
 echo;
 echo;
 echo +4096M;
 echo y;
 
  
 echo n;
 echo;
 echo;
 echo;
 echo y;
  
 echo w;
) | fdisk /dev/sda

echo 'Форматирование разделов'
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3

echo 'Создание и монтирование дисков.'
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda2
