# Автозапуск VM

Устанавливаем следующие программы на подкладку и перезагружаемся

1. lightdm - менеджер входа в систему
2. i3 - оконный менеджер
3. virtualbox
4. xorg - x сервер

    apt-get install xorg i3 lightdm virtualbox && reboot

----

При первом входе через lightdm , он багает и не пусает необходимо выбрать режим востановления в круглом окне правее имени пользователя, после чего перезагрузить и снова сменить оконный менеджер на обычный i3, не успею разобраться с чем это связанно и как пофиксить

----

## Отключение возможности переключения между tty

Для отключения возможности переключения между терминалами linux создаем следующий файл

    nano /etc/X11/xorg.conf

и добавьте следующие строки внутри:

    Section "ServerFlags"
        Option "DontVTSwitch" "true"
    EndSection

Перезагружаемся:

reboot

----

После авторизации откроется оконный менеджер i3, в нем для вызова консоли нажимаем сочитание клавишь win + enter

----

в корневой директории создаем папки auto_run и vm_image и выдаем права на запись в них

    mkdir /auto_run
    mkdir /vm_image

    chmod +r /auto_run
    chmod +r /vm_image

В /auto_run создаем bash скрипт startvm.sh

    nano startvm.sh
    
Вписываем:
____

    \#! /bin/bash
    VM_1_NAME=vm_1
    VM_HOME=/home/$USER/vm
    VM_IMAGE=/vm_image
    R_DELAY=1

    if [ ! -e $VM_HOME/$VM_1_NAME ]
    then
        mkdir -p $VM_HOME/$VM_1_NAME
        VBoxManage setproperty machinefolder $VM_HOME/$VM_1_NAME
        VBoxManage import $VM_IMAGE/$VM_1_NAME.ovf
    fi

    VBoxManage startvm $VM_1_NAME

    if [ -e $VM_HOME/$VM_1_NAME ]
    then
        while true
        do
            vb_status=$(pgrep -c VirtualBox)
            if [ $vb_status -ne 1 ]
            then
                #reboot
                poweroff
            fi
            sleep $R_DELAY
        done
    fi
----
Делаем файл исполняемым:

    chmod +x startvm.sh

Так же необходимо загрузить образ скомпилированной виртуальной машины:

    wget -P /vm_image https://yadi.sk/d/Q3Qb28R-VbuAqQ

Выходим из под рута и переходим в доманий каталог пользователя:

cd ~

Открываем файл конфигурации i3:

    nano .config/i3/config

дописываем в конец:

    exec /auto_run/startvm.sh

Все остальное содержимое файла либо стираем либо коментируем ибо оно отвечает за все возможные сочитания для переключения между окнами, выходом из оконного менеджера, открытие консоли в оконном менеджере, а так же отрисовку не нужного нам бара в низу икрана с ip временем и.т.п.

Снова перезагружаем систему:

    reboot
    
----

После первого старта некоторое время будет черный экран так как будет импортироваться виртуальная машина - процесс длительный

----
