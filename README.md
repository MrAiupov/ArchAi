# Arch Ai (Auto install)<br/>

Скрипт для автоматической установки Arch Linux на **пустой GPT** раздел.<br/>
(чуть позже обновлю скрипт для MBR, с возможностью выбора GPT/MBR)<br/>
<br/>
Если вы не знаете чем отличаются друг от друга GPT и MBR,<br/>
то могу посоветовать ознакомитmся с данной [статьёй](https://losst.ru/chem-otlichaetsya-mbr-ot-gpt "Losst.ru Чем отличается GPT от MBR").<br/>

Данный скрипт подходит лишь при условии что sda диск абсолютно **пустой** и имеет **GPT** разметку диска, скрипт создаст такие разделы:<br/>

- sda1 - **boot** раздел (1024 Mb)
- sda2 - **swap** раздел  (4096 Mb)
- sda3 - **root** раздел (остальное место на диске sda)

Во время установки, есть выбор:<br/>
- установки **KDE Plasma** (+ SDDM)<br/>
- установки **дополнительных программ** (они буду перечислены)<br/>
- установки драйверов **Nvidia**<br/>
- включение менеджера входа **SDDM** в автозагрузку **systemctl**<br/>
(включать, только если согласились на установку KDE)<br/>
- если **отказаться** от всех пунктов, то произойдёт **чистая** установка **Arch Linux**

### Запуск скрипта<br/>
Загружаемся в установщик Arch Linux, скаченного с официального сайта [archlinux.org](http://archlinux.org/download/ "Arch Linux Downloads").<br/>
Устанавливаем wget, для запуска скрипта.<br/>

    pacman -S wget  

Скачиваем и запускаем скрипт, который я сократил через сервис [git.io](http://git.io "git.io").<br/>

    wget git.io/JUC5C && sh JUC5C
