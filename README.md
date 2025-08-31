# Yandex Music для Fedora

[![GitHub stars](https://img.shields.io/github/stars/badges/shields.svg?style=social&label=Star)](https://github.com/username/yandex-music-fedora)  

Простое руководство по установке официального клиента Yandex Music в формате `.deb` на операционные системы, подобные Fedora (например, Fedora, Nobara, Ultramarine). Поскольку Fedora использует пакеты RPM, данное руководство описывает ручное извлечение и установку `.deb` пакета.

**Примечание:** Руководство предназначено для образовательных целей. Всегда скачивайте файлы с официальных источников, чтобы избежать рисков безопасности.

## Использование скрипта автоматической установки

Скрипт `install-yandex-music.sh` автоматизирует установку пакета `.deb` Yandex Music на системах, подобных Fedora. Следуйте этим шагам:

1. **Сохраните скрипт**: Скачайте или скопируйте скрипт `install-yandex-music.sh` в директорию, например, `~/Downloads/`.

2. **Сделайте скрипт исполняемым**: Перейдите в директорию со скриптом и установите права:
   ```bash
   cd ~/Downloads
   chmod +x install-yandex-music.sh
   ```

3. **Запустите скрипт**: В терминале введите имя скрипта, добавьте пробел, затем перетащите файл `.deb` (например, `Yandex_Music_amd64_5.66.1.deb`) в окно терминала, чтобы добавить полный путь. Нажмите Enter для запуска:
   ```bash
   ./install-yandex-music.sh ~/Downloads/Yandex_Music_amd64_5.66.1.deb
   ```
   Либо вручную введите полный путь к файлу `.deb`.

4. **Подтвердите установку**: Скрипт запросит подтверждение (y/n). Введите `y` для продолжения.

5. **Проверка ошибок**: Если скрипт сообщает об отсутствии библиотек, запустите приложение для выявления ошибок:
   ```bash
   /opt/Яндекс\ Музыка/yandexmusic
   ```
   Затем установите недостающие зависимости:
   ```bash
   dnf provides <missing_library>
   ```

**Примечания**:
- Убедитесь, что файл `.deb` скачан с официального сайта Yandex Music: [https://music.yandex.ru/download/](https://music.yandex.ru/download/).
- Для некоторых шагов скрипт требует `sudo` и запросит ваш пароль.
- При возникновении проблем проверьте вывод в терминале для получения информации об ошибках.

## Инструкции по ручной установке

1. **Скачайте пакет `.deb`** с официального сайта: [https://music.yandex.ru/download/](https://music.yandex.ru/download/)

2. **Перейдите в директорию** с файлом `.deb`:
   ```bash
   cd ~/Downloads/Yandex_Music_amd64_5.66.1
   ```

3. **Извлеките файл `.deb`**:
   ```bash
   ar x Yandex_Music_amd64_5.66.1.deb
   ```

4. **Распакуйте файл `data.tar.xz`**:
   ```bash
   tar -xvf data.tar.xz
   ```

5. **Создайте директорию приложения**, если она не существует:
   ```bash
   sudo mkdir -p /opt/Яндекс\ Музыка
   ```

6. **Переместите файлы приложения**:
   ```bash
   sudo mv data/opt/Яндекс\ Музыка/* /opt/Яндекс\ Музыка/
   ```

7. **Переместите файл рабочего стола**:
   ```bash
   sudo mv data/usr/share/applications/yandexmusic.desktop /usr/share/applications/
   ```

8. **Объедините иконки** с существующей директорией `hicolor`:
   ```bash
   sudo cp -r data/usr/share/icons/hicolor/* /usr/share/icons/hicolor/
   ```

9. **Объедините документацию**:
   ```bash
   sudo cp -r data/usr/share/doc/yandexmusic/* /usr/share/doc/yandexmusic/
   ```

10. **Установите разрешения**:
    ```bash
    sudo chmod +x /opt/Яндекс\ Музыка/yandexmusic
    sudo chmod 4755 /opt/Яндекс\ Музыка/chrome-sandbox
    ```

11. **Установите зависимости**:
    ```bash
    sudo dnf install libX11 libXcomposite libXdamage libXext libXfixes libXrandr mesa-libGL vulkan-loader
    ```

    > **Примечание:** Новые версии могут требовать дополнительные зависимости. Если не хватает библиотеки, определите и установите её:
    > ```bash
    > /opt/Яндекс\ Музыка/yandexmusic  # Ручной запуск для проверки ошибок
    > dnf provides <missing_library>   # Поиск и установка отсутствующей библиотеки
    > ```

12. **Обновите базу данных рабочего стола**, чтобы приложение появилось в wofi/rofi/appfinder:
    ```bash
    sudo update-desktop-database
    ```

13. **Запустите приложение**:
    ```bash
    /opt/Яндекс\ Музыка/yandexmusic
    ```
    Либо используйте меню приложений вашей среды рабочего стола (поиск “Yandex Music”).

14. **Необязательно: Очистка** (убедитесь, что вы находитесь в директории с извлеченными файлами):
    ```bash
    rm -rf control data control.tar.gz data.tar.xz debian-binary
    ```

## Устранение неполадок

- **Отсутствующие библиотеки**: Если приложение не запускается из-за отсутствия библиотек, запустите его в терминале, чтобы увидеть ошибку, затем используйте:
  ```bash
  dnf provides <missing_library>
  ```
  для поиска и установки нужного пакета.

- **Директория с не-ASCII символами**: Директория `Яндекс Музыка` использует кириллицу. Убедитесь, что ваша система поддерживает UTF-8:
  ```bash
  locale
  ```
  При необходимости установите локаль UTF-8:
  ```bash
  export LC_ALL=en_US.UTF-8
  ```
