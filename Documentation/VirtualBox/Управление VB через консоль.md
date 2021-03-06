# Управление VB через консоль

## Основные команды

Просмотр списка ВМ:

    VBoxManage list vms
    VBoxManage list vms --long | egrep '^(Name|State)'

Списиок потдерживаемых ОС:

    VBoxManage list ostypes

Удаление виртуальной машины и всех связанных с ней файлов:

    VBoxManage unregistervm SProtocol --delete

Оставновка виртуальной машины:

    VBoxManage controlvm SProtocol poweroff

Запуск ВМ с VNC:

    VBoxManage startvm SProtocol --type vrdp

Обычный запуск ВМ:

    vboxmanage startvm SProtocol

Информация о виртуальной машине

    vboxmanage showvminfo SProtocol

Экспорт VM:

    VBoxManage export SProtocol -0 /home/brotiger/Desktop/sprotocol/SProtocol.ovf

Cписок виртуальных машин:

    VBoxManage list vms
    
## Создание VM

Регистрируем новую виртуальную машину:

    VBoxManage createvm --name "SProtocol" --register

Создаём интерфейс, подключаем его в режиме bridge (тут enp2s0 — интерфейс на хост-машине):

    VBoxManage modifyvm "SProtocol" --nic1 bridged --bridgeadapter1 enp2s0 --nictype1 82540EM --cableconnected1 on

Указываем тип операционной системы:

    VBoxManage modifyvm "SProtocol" --ostype Ubuntu_64

Создаем диск для ВМ:

    VBoxManage createhd --filename /mnt/sdb/SProtocol/SProtocol.vdi --size 100000

Добавляем IDE контроллер к машине:

    VBoxManage storagectl "SProtocol" --name "IDE Controller" --add ide

Подключаем диск в ВМ:

    VBoxManage storageattach "SProtocol" --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium /mnt/sdb/SProtocol/SProtocol.vdi

Качаем ios образ системы:

    wget -P /iso http://releases.ubuntu.com/18.04/ubuntu-18.04.3-live-server-amd64.iso

Подключаем ISO с Ubuntu к ВМ:

    VBoxManage storageattach "SProtocol" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium /home/brotiger/Desktop/iso/ubuntu-18.04.3-live-server-amd64.iso

Устанавливем размер оперативной памяти ВМ:

    VBoxManage modifyvm "SProtocol" --memory 5120

Включаем VNC на ВМ:

    VBoxManage modifyvm SProtocol --vrde on
    VBoxManage modifyvm SProtocol --vrdeaddress 127.0.0.1

Запуск ВМ с VNC:

    VBoxManage startvm SProtocol --type vrdp

Обычный запуск ВМ:

    VBoxManage startvm SProtocol

## Установка RDP клиента

sudo apt install freerdp-x11
