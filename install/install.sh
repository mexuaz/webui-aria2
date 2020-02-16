#!/bin/bash

# Don't run the script as privileged user
if [[ $EUID -eq 0 ]]; then
   echo "You must not run the script as root or privileged user." 
   exit 1
fi


# Install aria2 if not installed
if [ $(dpkg-query -W -f='${Status}' aria2 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	sudo apt update
	sudo apt install aria2 -y
fi





# source directory of bash script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# aria2 configuration
[ ! -d $HOME/.aria2 ] && mkdir $HOME/.aria2
[ ! -f $HOME/.aria2/aria2.conf ] && cp $DIR/aria2.conf $HOME/.aria2/aria2.conf

# aria2c startup daemon
[ ! -d $HOME/.init ] && mkdir $HOME/.init
[ ! -f $HOME/.init/aria2.conf ] && cp $DIR/aria2_init.conf $HOME/.init/aria2.conf

# aria2c appliation menu desktop entry
DSKFILE="$HOME/.local/share/applications/aria2-webui.desktop"
rm $DSKFILE
cat > $DSKFILE << ENDOFFILE
[Desktop Entry]
Encoding=UTF-8
Name=Aria2 WebUI
Type=Application
Terminal=false
Categories=Network
ENDOFFILE
echo "Exec=sh -c \"aria2c --enable-rpc --rpc-listen-all; xdg-open $DIR/../docs/index.html\"" >> $DSKFILE
echo "Icon=$DIR/Network-Download-icon.png" >> $DSKFILE

chmod +x $DSKFILE







