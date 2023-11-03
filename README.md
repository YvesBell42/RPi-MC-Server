# RPi MC Server Optimisation and Automation

This project describes the setup, optimisation and automation of a Raspberry Pi Minecraft server.

A Raspberry Pi is not the ideal platform to run a Minecraft server, but can be perfect for a small number of friends wishing to play together. 

The hardware optimisations described enable greater flexibility when it comes to the number of players, plugins or mods. However, a simple and small server would function fine without these optimisations.















Essentially everything described is optional, however I have done my best to describe the process and dependencies to prevent things going wrong if not done the same.

The Raspberry Pi 4b has an 8GB model which is more than enough to alleviate a memory bottleneck when it comes to running a Minecraft Server. However, a Raspberry Pi is not the ideal platform to run a Minecraft Server in the first place, but the additional RAM allows for the implementation of a RAM Disk for faster chunk loading. The speed of s

Hardware:
- Raspberry Pi 4b (8GB Model)

- Overclocking

arm_freq=2200 (2300 achievable with winning silicon lottery ticket)

gpu_freq=750 (higher values possible and relates to ram frequency)

over_voltage=7 (maybe 6 or 8)

force_turbo=1 (voids warranty)
  
- Active Cooling

![ICE Tower Raspberry Pi 4 CPU Cooler](https://github.com/YvesBell42/RPi-MC-Server-Optimisation-and-Automation/assets/63612338/40789c81-c50c-480e-8851-6c23017c478f)

https://thepihut.com/products/ice-tower-raspberry-pi-4-cpu-cooler

- Storage

- RAM

  Software:
  - Rasberry Pi 64-bit OS (Headless as GUI Optional)

 64-bit allows for more than a GB of RAM to be allocated to a single process.
  
  - screen
 
  - PaperMC
 
  - java jdk / jre
 
  - ChunkLoader

  - Reverse Proxy (ngrok)

    https://ngrok.com/


RAM Disk:

sudo mkdir <PATH_TO_RAM_DISK_SERVER_FOLDER>

sudo nano /etc/fstab

tmpfs <PATH_TO_RAM_DISK_SERVER_FOLDER> tmpfs nodev,nosuid,size=1500M 0 0

sudo df -h

Server Automation Scripts:

- setup

- start

- save

- backup

- restart

  Cron Job Schedules:
  #After restart
  @reboot bash "/home/yves/Minecraft/setup.sh"

  #30th minute of each hour, e.g. 12:30, 13:30, 14:30
  30 * * * * bash <PATH_TO_SAVE_SCRIPT>

  #Every 6 hours, e.g. 12:00, 18:00, 24:00
  0 */6 * * * bash <PATH_TO_RESTART_SCRIPT>

  #Every 5 minutes, e.g. 12:00, 12:05, 12:10 
  */5 * * * * bash <PATH_TO_NGROK_UPDATE_SCRIPT>
  
