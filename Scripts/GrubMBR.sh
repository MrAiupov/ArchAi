echo 'Устанавливаем загрузчик для MBR'
pacman -Syy
pacman -S grub os-prober grub-customizer --noconfirm 
grub-install /dev/sda
