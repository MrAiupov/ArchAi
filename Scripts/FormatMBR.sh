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

echo '0.2 Форматирование разделов'
mkswap /dev/sda1
mkfs.ext4 /dev/sda2

echo '0.3 Создание и монтирование дисков'
mount /dev/sda2 /mnt
swapon /dev/sda1
