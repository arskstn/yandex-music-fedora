# Yandex Music for Fedora

[![GitHub stars](https://img.shields.io/github/stars/badges/shields.svg?style=social&label=Star)](https://github.com/username/yandex-music-fedora)  

A simple guide to installing the official Yandex Music client in `.deb` format on Fedora-like operating systems (e.g., Fedora, Nobara, Ultramarine). Since Fedora uses RPM packages, this guide describes manual extraction and installation of the `.deb` package.

**Note:** This guide is intended for educational purposes. Always download files from official sources to avoid security risks.

## Using the Automatic Installation Script

The script `install-yandex-music.sh` automates the installation of the Yandex Music `.deb` package on Fedora-like systems. Follow these steps:

1. **Save the script**: Download or copy the `install-yandex-music.sh` script into a directory, e.g., `~/Downloads/`.

2. **Make the script executable**: Navigate to the script’s directory and set the permissions:
   ```bash
   cd ~/Downloads
   chmod +x install-yandex-music.sh
   ```

3. **Run the script**: In the terminal, enter the script name, add a space, then drag and drop the `.deb` file (e.g., `Yandex_Music_amd64_5.66.1.deb`) into the terminal to add the full path. Press Enter to start:
   ```bash
   ./install-yandex-music.sh ~/Downloads/Yandex_Music_amd64_5.66.1.deb
   ```
   Or manually type the full path to the `.deb` file.

4. **Confirm the installation**: The script will ask for confirmation (y/n). Type `y` to continue.

5. **Check for errors**: If the script reports missing libraries, run the application to identify the errors:
   ```bash
   /opt/Яндекс\ Музыка/yandexmusic
   ```
   Then install the missing dependencies:
   ```bash
   dnf provides <missing_library>
   ```

**Notes**:
- Ensure the `.deb` file is downloaded from the official Yandex Music website: [https://music.yandex.ru/download/](https://music.yandex.ru/download/).
- Some steps in the script require `sudo` and will ask for your password.
- If issues occur, check the terminal output for error details.

## Manual Installation Instructions

1. **Download the `.deb` package** from the official website: [https://music.yandex.ru/download/](https://music.yandex.ru/download/)

2. **Navigate to the directory** containing the `.deb` file:
   ```bash
   cd ~/Downloads/Yandex_Music_amd64_5.66.1
   ```

3. **Extract the `.deb` file**:
   ```bash
   ar x Yandex_Music_amd64_5.66.1.deb
   ```

4. **Unpack the `data.tar.xz` file**:
   ```bash
   tar -xvf data.tar.xz
   ```

5. **Create the application directory**, if it doesn’t exist:
   ```bash
   sudo mkdir -p /opt/Яндекс\ Музыка
   ```

6. **Move the application files**:
   ```bash
   sudo mv data/opt/Яндекс\ Музыка/* /opt/Яндекс\ Музыка/
   ```

7. **Move the desktop file**:
   ```bash
   sudo mv data/usr/share/applications/yandexmusic.desktop /usr/share/applications/
   ```

8. **Merge icons** with the existing `hicolor` directory:
   ```bash
   sudo cp -r data/usr/share/icons/hicolor/* /usr/share/icons/hicolor/
   ```

9. **Merge documentation**:
   ```bash
   sudo cp -r data/usr/share/doc/yandexmusic/* /usr/share/doc/yandexmusic/
   ```

10. **Set permissions**:
    ```bash
    sudo chmod +x /opt/Яндекс\ Музыка/yandexmusic
    sudo chmod 4755 /opt/Яндекс\ Музыка/chrome-sandbox
    ```

11. **Install dependencies**:
    ```bash
    sudo dnf install libX11 libXcomposite libXdamage libXext libXfixes libXrandr mesa-libGL vulkan-loader
    ```

    > **Note:** Newer versions may require additional dependencies. If a library is missing, identify and install it:
    > ```bash
    > /opt/Яндекс\ Музыка/yandexmusic  # Run manually to check errors
    > dnf provides <missing_library>   # Find and install the missing library
    > ```

12. **Update the desktop database**, so the application appears in wofi/rofi/appfinder:
    ```bash
    sudo update-desktop-database
    ```

13. **Launch the application**:
    ```bash
    /opt/Яндекс\ Музыка/yandexmusic
    ```
    Or use your desktop environment’s application menu (search “Yandex Music”).

14. **Optional: Cleanup** (ensure you are in the directory with extracted files):
    ```bash
    rm -rf control data control.tar.gz data.tar.xz debian-binary
    ```

## Troubleshooting

- **Missing libraries**: If the application fails to start due to missing libraries, run it in the terminal to see the error, then use:
  ```bash
  dnf provides <missing_library>
  ```
  to find and install the required package.

- **Directory with non-ASCII characters**: The directory `Яндекс Музыка` uses Cyrillic characters. Ensure your system supports UTF-8:
  ```bash
  locale
  ```
  If necessary, set the UTF-8 locale:
  ```bash
  export LC_ALL=en_US.UTF-8
  ```
