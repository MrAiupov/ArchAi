# Arch Ai (Auto install)

Скрипт для автоматической установки **Arch Linux** на **sda** диск,<br/>
с возможностью выбора **GPT или MBR** разметки.<br/>
Внимание, все данные на sda диске **будут удалены**.<br/>
<br/>
Если вы не знаете какая вам нужна разметка<br/>
и чем вообще они отличаются GPT от MBR,<br/>
то могу посоветовать ознакомитmся с данной [статьёй](https://losst.ru/chem-otlichaetsya-mbr-ot-gpt "Losst.ru Чем отличается GPT от MBR").<br/>
<br/>
Обязательно прочитайте статью, чтобы разобраться в данном вопросе,<br/>
потому что после запуска скрипта, обязательно нужно будет выбрать метод разметки **GPT или MBR**.<br/>
и от этого будет зависеть создание разделов и метод установки **загрузчика GRUB**.<br/>
<br/>
Если выбрать установку на **пустой** диск с **GPT** разметкой диска,<br/>
скрипт во время установки создаст такие разделы:<br/>
- sda1 - **boot** раздел (1024 Mb)<br/>
- sda2 - **swap** раздел  (4096 Mb)<br/>
- sda3 - **root** раздел (остальное место на диске sda)<br/>

Если выбрать установку на **пустой** диск с **MBR** разметкой диска,<br/>
скрипт во время установки создаст такие разделы:<br/>
- sda1 - **swap** раздел  (4096 Mb)<br/>
- sda2 - **root** раздел (остальное место на диске sda)<br/>

Во время установки, скрипт также будет давать возможность выбора:<br/>
- установки **KDE Plasma** (+ SDDM)<br/>
- установки **дополнительных программ** (они буду перечислены перед установкой)<br/>
- установки драйверов **Nvidia**<br/>
- включение менеджера входа **SDDM** в автозагрузку **systemctl**<br/>
(включать, только если согласились на установку KDE Plasma)<br/>
- если **отказаться** от всех пунктов, то произойдёт **чистая** установка **Arch Linux***<br/>
<br/>

### Запуск скрипта <br/>

Загружаемся в установщик Arch Linux, скаченного с официального сайта [archlinux.org](https://www.archlinux.org/download/) <br/>
Самым первым делом, мы проверим наименование дисков в вашей системе.<br/>

        lsblk
и только после того как убедитесь, что sda диск именно тот, то можете начать установку.<br/>
<br/>
Первым делом, устанавливаем wget, для запуска скрипта.<br/>

    pacman -S wget  
Скачиваем и запускаем скрипт, который я сократил через сервис [git.io](http://git.io "git.io").<br/>

    wget git.io/JUC5C && sh JUC5C
