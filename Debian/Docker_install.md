# Установка Docker  

    apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common

## Добавяем в систему GPG-ключ репозитория Docker
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
## Добавляем этот репозиторий Docker в APT
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
## Обновляем индекс пакетов
    apt update
## Переключаемся из репозитория Debian в репозиторий Docker
    apt-cache policy docker-ce
## Устанавливаем Docker
    apt install docker-ce 
## Чтобы убедиться в том, что программа работает, запрашиваем её состояние
    systemctl status docker
    
    Команда должна показать что то подобное:
        docker.service - Docker Application Container Engine
        Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
        Active: active (running) since Mon 2019-07-08 15:11:19 UTC; 58s ago
        Docs: https://docs.docker.com
        Main PID: 5709 (dockerd)
        Tasks: 8
        Memory: 31.6M
        CGroup: /system.slice/docker.service
        └─5709 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
