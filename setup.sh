#!/bin/bash
# <USER> will be replaced with install script.
RAM_DiskDir=/home/<USER>/RPi-MC-Server/RAM_Disk
PersistentDir=/home/<USER>/RPi-MC-Server/Persistent
StartScript=/home/<USER>/RPi-MC-Server/start.sh

# Copy files from persistent server folder to RAM Disk server folder.
sudo cp -R $PersistentDir/* $RAM_DiskDir/

# Call start script for server.
sudo bash $StartScript
