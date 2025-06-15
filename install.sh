#!/bin/bash

# Create directories.
mkdir Persistent
mkdir RAM_Disk
mkdir Backups

# Fix permissions.
sudo chown $SUDO_USER Persistent
sudo chown $SUDO_USER RAM_Disk
sudo chown $SUDO_USER Backups

# Create RAM Disk (1500MB).
sudo su -c "echo tmpfs /home/"$SUDO_USER"/RPi-MC-Server/RAM_Disk tmpfs nodev,nosuid,size=1500M 0 0 >> /etc/fstab"

# Modify automation script directories.
sudo sed -i -e "s/<USER>/$SUDO_USER/g" start.sh
sudo sed -i -e "s/<USER>/$SUDO_USER/g" save.sh
sudo sed -i -e "s/<USER>/$SUDO_USER/g" restart.sh
sudo sed -i -e "s/<USER>/$SUDO_USER/g" backup.sh
sudo sed -i -e "s/<USER>/$SUDO_USER/g" ngrok_update.sh

# Install required packages.
sudo apt install default-jdk -y
sudo apt install screen -y

# Check if install ngrok?
read -p "Install ngrok? (Y/N): " ngrok
if [[ $ngrok  == [yY] ]]
then
	# Download ngrok.
	wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz
	# Unzip binary.
	tar -xvzf ngrok-v3-stable-linux-arm64.tgz
 	rm ngrok-v3-stable-linux-arm64.tgz --force
  	sudo chown $SUDO_USER ngrok

	# Setup ngrok
	read -p "Enter ngrok authtoken: " authtoken
	./ngrok authtoken $authtoken
	./ngrok config check
 	#Authtoken saved to configuration file: /root/.config/ngrok/ngrok.yml
  	# Create ngrok config for minecraft server.
 	echo "tunnels:" >>  /root/.config/ngrok/ngrok.yml
	echo "    minecraft-server:" >>  /root/.config/ngrok/ngrok.yml
	echo "        proto: tcp" >>  /root/.config/ngrok/ngrok.yml
	echo "        addr: 25565" >>  /root/.config/ngrok/ngrok.yml

	# Create a service for ngrok.
	sudo echo [Unit] > /etc/systemd/system/ngrok-client.service
	sudo echo Description=ngrok client >> /etc/systemd/system/ngrok-client.service
	sudo echo After=network.target >> /etc/systemd/system/ngrok-client.service
	sudo echo [Service] >> /etc/systemd/system/ngrok-client.service
 	sudo echo ExecStart=/home/$SUDO_USER/RPi-MC-Server/ngrok start --all --config /root/.config/ngrok/ngrok.yml >> /etc/systemd/system/ngrok-client.service
	sudo echo Restart=on-abort >> /etc/systemd/system/ngrok-client.service
	sudo echo [Install] >> /etc/systemd/system/ngrok-client.service
	sudo echo WantedBy=multi-user.target >> /etc/systemd/system/ngrok-client.service

	# Start ngrok service.
	sudo systemctl daemon-reload
	sudo systemctl enable ngrok-client
	sudo systemctl start ngrok-client
 	# Check if service running.
  	#sudo systemctl status ngrok-client.service

  	# Check if setup GitHub repository?
	read -p "Setup GitHub repository? (Y/N): " github
	if [[ $github  == [yY] ]]
	then
		# Get user and repository details.
		read -p "Enter GitHub email address: " email
  		read -p "Enter GitHub username: " username
   		read -p "Enter GitHub repository URL: " url

		# Enable credential storing.
      		git config --global credential.helper store
  
    		# Set git config details.
		git config --global user.email $email
 		git config --global user.name $username
		
		# Create repository directory.
		cd /home/"$SUDO_USER"/RPi-MC-Server
		mkdir ngrok_git
		cd ngrok_git
		git init

    		# Link local repo to remote repo.
		git remote add origin $url
		git remote -v
		
    		# Push README.md
		touch README.md
		git add README.md
		git commit -am "init"
		git push origin HEAD:main --force
  		cat /home/$SUDO_USER/.git-credentials
	fi
fi

# Download latest PaperMC.
cd /home/$SUDO_USER/RPi-MC-Server/Persistent
version="1.21.4"
latest_build="232"
wget https://api.papermc.io/v2/projects/paper/versions/"$version"/builds/"$latest_build"/downloads/paper-"$version"-"$latest_build".jar
mv paper-"$version"-"$latest_build".jar server.jar

# Create eula.
echo eula=true > eula.txt
cd ..

# Copy current cron file.
sudo crontab -l > tmpcron

# Append cron commands.
#After restart.
echo "@reboot bash /home/"$SUDO_USER"/RPi-MC-Server/setup.sh" >> tmpcron
#30th minute of each hour, e.g. 12:30, 13:30, 14:30.
echo "30 * * * * bash /home/"$SUDO_USER"/RPi-MC-Server/save.sh" >> tmpcron
#Every 8 hours, e.g. 8:00, 16:00, 24:00.
echo "0 */8 * * * bash /home/"$SUDO_USER"/RPi-MC-Server/restart.sh" >> tmpcron
if [[ $ngrok  == [yY] ]]
then
	#Every 5 minutes, e.g. 12:00, 12:05, 12:10.
	echo "*/5 * * * * bash /home/"$SUDO_USER"/RPi-MC-Server/ngrok_update.sh" >> tmpcron
fi

# Install new cron file.
sudo crontab tmpcron

# Remove temporary file.
rm tmpcron

# Reboot and server will start.
#sudo reboot
