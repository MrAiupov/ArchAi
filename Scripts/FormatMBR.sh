# wget git.io/JUWeC && sh JUWeC
echo 'Создание разделов'
(
  echo o;

  echo n;
  echo;
  echo;
  echo +4096M;
  echo;

  echo n;
  echo;
  echo;
  echo;
  echo y;

  echo w;
) | fdisk /dev/sda

echo 'Форматирование разделов'
mkswap /dev/sda1
mkfs.ext4 /dev/sda2

echo 'Создание и монтирование дисков'
mount /dev/sda2 /mnt
swapon /dev/sda1
