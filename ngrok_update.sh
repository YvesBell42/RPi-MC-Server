#!/bin/bash
# Change the directory path according to your setup.
GitDir=<PATH_TO_GIT_REPO>

# Grab tunnel information from ngrok localhost page.
curl -s http://localhost:4040/api/tunnels/minecraft-server > ngrok_tunnel.txt

# Process text to find the web address.
str=$(awk -F',' '{print $3}' ngrok_tunnel.txt)
str=${str:20:50}
# Assign to string.
Current=$(echo $str | tr -d \")
# Read last web address from repository README.
Last=$(cat $GitDir/README.md)

# Check if they are different.
if [[ $Current != $Last ]]
then
    # Git requires active directory to be repository.
    cd $GitDir
    # Replace README.md with new address.
    echo $Current > README.md
    # Commit
    git commit -am "Update IP"
    # Push
    git push -u origin main
fi
