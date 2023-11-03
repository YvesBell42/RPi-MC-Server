#!/bin/bash
# Change these directory paths according to your setup.
BackupDir=<PATH_TO_BACKUPS_FOLDER>
PermDir=<PATH_TO_PERSISTENT_SERVER_FOLDER>

# Zip persistent server files with time and date.
sudo zip -r "$BackupDir/world-$(date +%M-%H-%d-%m-%Y).zip" "$PermDir/world"

