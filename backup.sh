#!/bin/bash
# <USER> will be replaced with install script.
BackupDir=/home/<USER>/RPi-MC-Server/Backups
PersistentDir=/home/<USER>/RPi-MC-Server/Persistent

# Zip persistent server files with time and date.
sudo zip -r "$BackupDir/world-$(date +%M-%H-%d-%m-%Y).zip" "$PersistentDir/world"

