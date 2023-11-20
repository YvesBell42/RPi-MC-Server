#!/bin/bash
RAM_DiskDir=/home/"$(whoami)"/RPi-MC-Server/RAM_Disk
PersistentDir=/home/"$(whoami)"/RPi-MC-Server/Persistent
StartScript=/home/"$(whoami)"/RPi-MC-Server/start.sh

# Copy files from persistent server folder to RAM Disk server folder.
sudo cp -R $PersistentDir/* $RAM_DiskDir/

# Call start script for server.
sudo bash $StartScript
