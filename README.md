# RPi MC Server Optimisation and Automation

This project describes the setup, optimisation and automation of a Raspberry Pi Minecraft server.

A Raspberry Pi is not the ideal platform to run a Minecraft server, but can be perfect for a small number of friends wishing to play together (especially when optimised and automated). 

The hardware optimisations described enable greater flexibility when it comes to the number of players, plugins or mods. However, a simple and small server would function fine without these optimisations.

The Raspberry Pi 4b can offer 8GB of memory which allows for a large allocation of RAM to the server, and more that could be used as a RAM Disk. Running the server off a RAM Disk means pre-generated chunks are loaded much faster, but adds some risk of data corruption if handled badly. The automation scripts have been designed to prevent associated corruption and offer regular restore points. 

The use of a RAM Disk means that the storage device used only affects the speed of server start, restart, saving and backup. However, fast storage wouldn't be missed, such as from a fast USB drive, external NVMe adpated to USB3.0 (with powered HUB) or even PCIe SSD with the Raspberry Pi 5. I decided to use a ADATA XPG SX8200 Pro 256GB adpated to USB3.0 with an enclosure (https://www.amazon.co.uk/gp/product/B07TXCMQ8B) and powered hub (https://www.amazon.co.uk/RSHTECH-Aluminum-Portable-Splitter-Individual/dp/B07KFGY2CR).

Overclocking the Raspbery Pi has the most impactful performance improvement but will require active cooling (Raspberry Pi 5 needs cooling anyway). A small fan and/or heatsink may be enough, but I opted for the overkill ICE Tower (https://thepihut.com/products/ice-tower-raspberry-pi-4-cpu-cooler) just in case, and because it looks cool :sunglasses:.

![ICE Tower Raspberry Pi 4 CPU Cooler](https://github.com/YvesBell42/RPi-MC-Server-Optimisation-and-Automation/assets/63612338/40789c81-c50c-480e-8851-6c23017c478f)











Hardware:
- Raspberry Pi 4b (8GB Model)

- Overclocking

arm_freq=2200 (2300 achievable with winning silicon lottery ticket)

gpu_freq=750 (higher values possible and relates to ram frequency)

over_voltage=7 (maybe 6 or 8)

force_turbo=1 (voids warranty)
  
- Active Cooling


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
  
