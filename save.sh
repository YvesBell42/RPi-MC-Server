#!/bin/bash
RAM_DiskDir=/home/<USER>/RPi-MC-Server/RAM_Disk
PersistentDir=/home/<USER>/RPi-MC-Server/Persistent
BackupScript=/home/<USER>/RPi-MC-Server/backup.sh

# Check if minecraft server process is found in screen terminals.
if ! sudo screen -list | grep -q minecraft
then
    # Server is not running.
    # Call backup script.
    sudo bash $BackupScript
    # Server has likely crashed if not running so report.
    date >> "$RAM_DiskDir/crashes.txt"
    # Copy RAM Disk server files to persistent server folder.
    sudo cp -R $RAM_DiskDir/* $PersistentDir/
    # Restart just in case as server no running anyway.
    sudo reboot
    # Backup is made before saving files to persistent because if the server
    # has crashed then there is a possibility of corruption.
else
    # Server is running.
    # Use screen to tell players that the server is saving.
    sudo screen -r minecraft -X stuff "say Saving...$(printf '\r')"
    # Use screen to toggle saving.
    sudo screen -r minecraft -X stuff "save-off$(printf '\r')"
    sudo screen -r minecraft -X stuff "save-all$(printf '\r')"
    # Wait 10 seconds for save to finish.
    sleep 10s
    # Copy RAM Disk server files to persistent server folder.
    sudo cp -R $RAM_DiskDir/* $PersistentDir/
    # Use screen to toggle saving.
    sudo screen -r minecraft -X stuff "save-on$(printf '\r')"
fi
