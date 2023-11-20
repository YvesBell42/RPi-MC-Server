#!/bin/bash
BackupDir=/home/"$(whoami)"/RPi-MC-Server/Backups
PersistentDir=/home/"$(whoami)"/RPi-MC-Server/Persistent

# Zip persistent server files with time and date.
sudo zip -r "$BackupDir/world-$(date +%M-%H-%d-%m-%Y).zip" "$PersistentDir/world"

