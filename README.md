# RPi MC Server Optimisation and Automation

This project includes the setup and scripts for a fully automated Minecraft server running on a Raspberry Pi. 

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

- SSD

- RAM

  Software:
  - screen
 
  - PaperMC

Networking:
- SSH

- Reverse Proxy (ngrok)
  https://ngrok.com/

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
  30 * * * * bash "/home/yves/Minecraft/save.sh"

  #Every 6 hours, e.g. 12:00, 18:00, 24:00
  0 */6 * * * bash "/home/yves/Minecraft/restart.sh"

  #Every 5 minutes, e.g. 12:00, 12:05, 12:10 
  */5 * * * * bash "/home/yves/Minecraft/ngrok_update.sh"
  
