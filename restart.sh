#!/bin/bash
# <USER> will be replaced with install script.
BackupDir=/home/<USER>/RPi-MC-Server/Backups
PersistentDir=/home/<USER>/RPi-MC-Server/Persistent
SaveScript=/home/<USER>/RPi-MC-Server/save.sh
BackupScript=/home/<USER>/RPi-MC-Server/backup.sh
StartScript=/home/<USER>/RPi-MC-Server/start.sh

# Restart script can be called manually with option 'now' for instant effect.
if [ "$1" != "now" ]
then
    # Use screen to tell players that the server will restart soon.
    sudo screen -r minecraft -X stuff "$(printf '\r')say Restarting in 5 minutes!$(printf '\r')"
    # Print for terminal if called manually.
    echo Server restarting in 5 minutes!
    # Wait 4 minutes.
    sleep 4m
fi

if [ "$1" != "now" ]
then
    # Use screen to tell players that the server will restart soon.
    sudo screen -r minecraft -X stuff "say Restarting in 60 seconds!$(printf '\r')"
    # Print for terminal if called manually.
    echo Server restarting in 60 seconds!
    # Wait 60 seconds.
    sleep 1m
fi

# Call save script.
sudo bash $SaveScript

# Use screen to safely shutdown server.
sudo screen -r minecraft -X stuff "stop$(printf '\r')"

# Wait until screen terminal has closed.
while sudo screen -list | grep -q minecraft
do
    :
done

# Report a restart.
date >> "$PersistentDir/restarts.txt"

# Call backup script.
sudo bash $BackupScript

# Reboot on restart.
sudo reboot
# Optional call server start script instead of reboot.
#sudo bash $StartScript
