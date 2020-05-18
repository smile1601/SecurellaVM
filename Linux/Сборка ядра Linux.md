# Сборка ядра linux

Качаем [файлы ядра]([https://www.kernel.org/)
    
Устанавливаем все необходимые утилиты для сборки ядра:
    
    apt install build-essential libncurses-dev bison flex libssl-dev libelf-dev
    apt install isolinux genisoimage
    
Конфигурация ядра:

    make nconfig
    
Сборка ядра:

    make -j8 isoimage
    
j8 - количество потоков