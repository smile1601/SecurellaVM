# Сборка VB из исходников

Устанавливаем следующие пакеты:

    apt-get install iasl
    apt-get install wine-stable
    apt-get install xsltproc
    apt-get install libxml2
    apt-get install libxml2-dev
    apt-get install libidl-dev
    apt-get install libssl-dev
    apt-get install libcurl4-openssl-dev
    apt-get install libvpx-dev
    apt-get install libopus-dev
    apt-get install libpng-dev
    apt-get install libsdl-dev
    apt-get install libxcursor-dev
    apt-get install libxinerama-dev
    apt-get install libxrandr-dev
    apt-get install libxmu-dev
    apt install qt5-default
    apt-get install libdevmapper-dev
    apt-get install libcap-dev
    apt-get install g++-multilib
    apt-get install makeself
    apt-get install puthon-dev
    apt-get install kbuild
    apt-get install libpam0g-dev
    apt-get install libqt5*
    apt-get install default-jdk
    apt-get install -y ruby-posix-spawn
    apt-get install texlive-latex-base
    apt-get install yasm
    apt-get install qttools5-dev-tools
    apt-get install texlive-latex-extra texlive-latex-recommended
    apt-get install texlive-fonts-extra texlive-fonts-recommended

(На 64 разрядной машине требует 32 битные библиотеки)

Выполняем следующие команды:

	ln -s libX11.so.6    /usr/lib32/libX11.so 
	ln -s libXTrap.so.6  /usr/lib32/libXTrap.so 
	ln -s libXt.so.6     /usr/lib32/libXt.so 
	ln -s libXtst.so.6   /usr/lib32/libXtst.so
	ln -s libXmu.so.6    /usr/lib32/libXmu.so
	ln -s libXext.so.6   /usr/lib32/libXext.so

Выполняем команду:

	./configure --disable-hardening 

Запускаем сценарий установки среды:

	source ./env.sh

Эта команда создаст необходимые двоичные файлы в out / linux.x86 / release / bin /

	kmk all

В корневом каталоге с исходниками VirtualBox создаем LocalConfig.kmk и пишем в него следующее:

    #Личный каталог приложения зависящий от архитектуры
    VBOX_PATH_APP_PRIVATE_ARCH := /usr/lib/virtualbox
    #Путь для расположения каких то библиотек
    VBOX_PATH_SHARED_LIBS := $(VBOX_PATH_APP_PRIVATE_ARCH)
    #Отключаем стандартный RUNPATH что бы использовать фиксированный
    VBOX_WITH_ORIGIN :=
    #Устанавливаем RUNPATH в каталог, где находятся наши общие библиотеки
    VBOX_WITH_RUNPATH := $(VBOX_PATH_APP_PRIVATE_ARCH)
    #Личный каталог приложения не зависящий от архитектуры
    VBOX_PATH_APP_PRIVATE := /usr/share/virtualbox
    #Каталог содержащий документацию VirtualBox
    VBOX_PATH_APP_DOCS := /usr/share/doc/virtualbox
    #Для экономии времени компиляции, отключает какое то тестирование
    VBOX_WITH_TESTCASES :=
    #Для экономии времени компиляции, отключает какое то тестирование
    VBOX_WITH_TESTSUITE :=

Сборка и установка модуля ядра VirtualBox:

	cd out/linux.amd64/release/bin/src
	make
	make install
	modprobe vboxdrv

Запуск VirtualBox:
	
	cd..
	./VirtualBox
