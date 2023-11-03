#!/bin/bash
# Change these directory paths according to your setup.
TempDir=<PATH_TO_RAM_DISK_SERVER_FOLDER>
PermDir=<PATH_TO_PERSISTENT_SERVER_FOLDER>
StartScript=<PATH_TO_START_SCRIPT>

# Copy files from persistent server folder to RAM Disk server folder.
sudo cp -R $PermDir/* $TempDir/

# Call start script for server.
sudo bash $StartScript
