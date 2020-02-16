#!/bin/bash

# Install aria2
sudo apt update
sudo apt install aria2 -y

# source directory of bash script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# aria2 configuration
mkdir $HOME/.aria2
cp $DIR/aria2.conf $HOME/.aria2/aria2.conf

# aria2c startup daemon
mkdir $HOME/.init
cp $DIR/aria2_init.conf $HOME/.init/aria2.conf

# aria2c appliation menu desktop entry
DSKFILE="$HOME/.local/share/applications/aria2-webui.desktop"
cat > $DSKFILE << ENDOFFILE
[Desktop Entry]
Encoding=UTF-8
Name=Aria2 WebUI
Type=Link
Terminal=false
Categories=Network
ENDOFFILE
echo "URL=file://$DIR/../docs/index.html" >> $DSKFILE
echo "Icon=$DIR/Network-Download-icon.png" >> $DSKFILE

sudo chmod +x $DSKFILE







