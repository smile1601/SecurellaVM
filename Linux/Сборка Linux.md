# Сборка Linux

## Для сборки нам понадобится:

1)apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev isolinux genisoimage

## Для конфигурации:

2)mkdir /linuxkernel

3)cd /linuxkernel

4)wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.6.2.tar.xz

5)tar -xvf linux-5.6.2.tar.xz

6)rm -r linux-5.6.2.tar.xz

7)chmod -r 777 /linuxkernel

8)cp -r /linuxkernel/linux-5.6.2/* /linuxkernel/

9)rm -r linux-5.6.2

10)make defconfig

11)make -j8 bzImage #j8 количество потоков

12)make install

----

После этого в папочке /boot/ появится 2 новых файла, один из них это ядро второй это RamDisk, их автоматически собрала Ubuntu
в RamDisk входит какие каталоги будут при загрузки системы, busybox, инициализация первого процесса и терминала

Ядро называется как то - vzlinuz-5.6.2...

RamDisk он же в последствии initrd - vzlinuz.img-5.6.2...

----

## Монтируем флешку на которую поставим операционку

13)mkdir /mnt/usb

14)mount /dev/sdd1 /mnt/usb

15)mkdir /mnt/usb/boot

16)cd /boot

17)cp vzlinuz-5.6.2...  /mnt/usb/boot

18)cp vzlinuz.img-5.6.2... /mnt//usb/boot

Теперь необходиммо поставиить загрузщик на флешку

19)grub-install --root-directory=/mnt/usb/boot /dev/sdd

Здесь мы указываем параметр --root-directory, это та папка, которая будет считаться корнем системы,
и откуда будут браться файлы загрузчика при старте. Установщик автоматически скопирует их туда.
Устройство /dev/sdc - ваша флешка.(https://losst.ru/ustanovka-grub-na-fleshku)

20)cd /etc/grub.d/ 

>(http://rus-linux.net/MyLDP/boot/GRUB2-full-tutorial.html)

21)nano 11_theool

Вписываем в данный файл следующее:

    \#!/bin/sh -e
    echo "Adding my custom Linux to GRUB 2"
    cat << EOF
    menuentry "TheOol" {
    set root=(hd0,1)
    linux /boot/vmlinuz-5.6.2...
    initrd /boot/vmlinuz.img-5.6.2...
    }
    EOF

22)chmod +x 11_theool

23)mkdir /mnt/usb/boot/grub

24)update-grub -o /mnt/usb/boot/grub/grub.cfg

Залезаем в только что созданный файл конфигурации и вырезаем от туда все лишнее (операционки которые граб автоматически туда вписал найдя их на вашем пк)

----

Если вдруг при загрузки каким то образом нумерация дисков изменится и флешка будет не 0 девайсом, то в загрузчике GRUB наводим на theool и нажимает E, редактируем файл с загрузкой и нажимаем F10

