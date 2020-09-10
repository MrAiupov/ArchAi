echo 'wget git.io/JUWeB && sh JUWeB'
echo 'Устанавливаем загрузчик для GPT'
pacman -Syy
pacman -S grub efibootmgr os-prober grub-customizer --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
