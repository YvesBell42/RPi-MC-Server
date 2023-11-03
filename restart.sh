#!/bin/bash
# Change these directory paths according to your setup.
BackupDir=<PATH_TO_BACKUPS_FOLDER>
PermDir=<PATH_TO_PERSISTENT_SERVER_FOLDER>
SaveScript=<PATH_TO_SAVE_SCRIPT>
BackupScript=<PATH_TO_BACKUP_SCRIPT>
StartScript=<PATH_TO_START_SCRIPT>

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
date >> "$PermDir/restarts.txt"

# Call backup script.
sudo bash $BackupScript

# Optional reboot on restart.
# If crontab is setup correctly the server would start on reboot.
#sudo reboot

# Call server start script.
sudo bash $StartScript
