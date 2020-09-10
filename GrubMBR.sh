echo '1.4.1 Устанавливаем загрузчик для MBR'
pacman -Syy
pacman -S grub os-prober grub-customizer --noconfirm 
grub-install /dev/sda
