#!/bin/bash

set -e  # Exit on error

usage() {
    echo "Usage: $0 <path_to_deb_file>"
    echo "Example: $0 ~/Downloads/Yandex_Music_amd64_5.66.1.deb"
    exit 1
}

if [ $# -ne 1 ]; then
    usage
fi

DEB_FILE="$1"

if [ ! -f "$DEB_FILE" ] || [ "${DEB_FILE##*.}" != "deb" ]; then
    echo "Error: File does not exist or is not a .deb file."
    exit 1
fi

TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT  # Cleanup on exit

cd "$TEMP_DIR"
ar x "$DEB_FILE"
tar -xvf data.tar.xz

echo "This script will install Yandex Music to /opt/Яндекс Музыка/ and system directories."
read -p "Continue? (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo "Installation aborted."
    exit 0
fi

sudo mkdir -p /opt/Яндекс\ Музыка

sudo mv data/opt/Яндекс\ Музыка/* /opt/Яндекс\ Музыка/
sudo mv data/usr/share/applications/yandexmusic.desktop /usr/share/applications/
sudo cp -r data/usr/share/icons/hicolor/* /usr/share/icons/hicolor/
sudo cp -r data/usr/share/doc/yandexmusic/* /usr/share/doc/yandexmusic/

sudo chmod +x /opt/Яндекс\ Музыка/yandexmusic
sudo chmod 4755 /opt/Яндекс\ Музыка/chrome-sandbox

echo "Installing dependencies..."
sudo dnf install -y libX11 libXcomposite libXdamage libXext libXfixes libXrandr mesa-libGL vulkan-loader

sudo update-desktop-database

echo "Installation complete! Launch with: /opt/Яндекс\ Музыка/yandexmusic"
echo "If missing libraries: Run the app to check errors, then 'dnf provides <missing_library>'"

rm -rf control data control.tar.gz data.tar.xz debian-binary

echo "Done!"
