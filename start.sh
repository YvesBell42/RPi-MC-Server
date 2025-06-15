#!/bin/bash
#screen -dmS minecraft java -server -jar -Xms6656M -Xmx6656M -XX:+AlwaysPreTouch -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:+ParallelRefProcEnabled server.jar nogui
#java -server -jar -Xms6656M -Xmx6656M -XX:+AlwaysPreTouch -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -Dsun.rmi.dgc.server.gcInterval=2147483646 paper-195.jar

#-XX:ParallelGCThreads=6
#-XX:+UseConcMarkSweepGC instead of G1GC? Benefits from more processors and reduces pause
#-XX:+UseParNewGC removed in jre java 9
#-XX:+DisableExplicitGC for mods and plugins

#-XX:MaxGCPauseMillis=30 
#-XX:GCPauseIntervalMillis=150
#-XX:+UseAdaptiveGCBoundary
#-XX:-UseGCOverheadLimit
#-XX:+UseBiasedLocking
#-XX:+PerfDisableSharedMem
#-Dfml.ignorePatchDiscrepancies=true
#-Dfml.ignoreInvalidMinecraftCertificates=true
#-XX:+UseFastAccessorMethods
#-XX:+UseCompressedOops used at 2Gb but not 4Gb and used again when lots of mods. 64 bit JVM required and generally used with heaps below 32Gb
#-XX:+OptimizeStringConcat
#-XX:+AggressiveOpts

#-XX:+ParallelRefProcEnabled
#-XX:MaxGCPauseMillis=200
#-XX:ParallelGCThreads=4 increases with RAM? Common to all garbage collectors. G1 constrains threads by HeapSizePerGCThread
#-XX:ConcGCThreads= Common to all garbage collectors and ParallelGCThreads / 4 by default
#-XX:+UseParallelGC

#G1HeapRegionSize=1,2,4,8...,32MB

RAM_DiskDir=/home/<USER>/RPi-MC-Server/RAM_Disk

sudo screen -dmS minecraft java -server -jar -Xms5000M -Xmx5000M -XX:+AlwaysPreTouch -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -Dsun.rmi.dgc.server.gcInterval=2147483646 $RAM_DiskDir/server.jar

#java -Xms128M -Xmx6500M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 
#-XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 
#-XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true 
#-jar /opt/minecraft/server.jar nogui
