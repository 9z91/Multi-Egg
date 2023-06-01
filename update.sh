#!/bin/bash

HOST_NAME=Multi-Egg

PAPER_1_8_8=https://api.papermc.io/v2/projects/paper/versions/1.8.8/builds/445/downloads/paper-1.8.8-445.jar
PAPER_1_12_2=https://api.papermc.io/v2/projects/paper/versions/1.12.2/builds/1620/downloads/paper-1.12.2-1620.jar
PAPER_1_16_5=https://api.papermc.io/v2/projects/paper/versions/1.16.5/builds/794/downloads/paper-1.16.5-794.jar
PAPER_1_18_2=https://api.papermc.io/v2/projects/paper/versions/1.18.2/builds/388/downloads/paper-1.18.2-388.jar
PAPER_1_19_4=https://api.papermc.io/v2/projects/paper/versions/1.19.4/builds/542/downloads/paper-1.19.4-542.jar

STARTUP_FLAGS="-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"

display_motd() {
  echo -e "\033c"
  printf "==========================================================================\n"
  figlet -l $HOST_NAME
  printf "==========================================================================\n"
}

agree_eula() {
  echo "Do you agree to the Minecraft EULA?"
  select yn in "Yes" "No"; do
    case $yn in
    Yes)
      echo "eula=true" >eula.txt
      exit 1
      ;;
    No) exit ;;
    *) exit ;;
    esac
  done
}

install_mc() {
  echo "Which version of Minecraft?"
  select version in 1.8 1.12 1.16.5 1.19.4; do
    case $version in
    "1.8")
      install_paper 8
      ;;
    "1.12")
      install_paper 11
      ;;
    "1.16.5")
      install_paper 16
      ;;
    "1.19.4")
      install_paper 17
      ;;
    *)
      echo "Invalid server version."
      exit 1
      ;;
    esac
  done
}

install_paper() {
  case $1 in
  8)
    # Paper 1.8.8
    curl -o server.jar $PAPER_1_8_8
    ;;
  11)
    # Paper 1.12.2
    curl -o server.jar $PAPER_1_12_2
    ;;
  16)
    # Paper 1.16.5
    curl -o server.jar $PAPER_1_16_5
    ;;
  17)
    # Paper 1.19.4
    curl -o server.jar $PAPER_1_19_4
    ;;
  esac
  agree_eula
  exit
}

select_server() {
  echo "Which platform are you gonna use?"
  select type in Minecraft Discord NodeJS; do
    case $type in
    "Minecraft")
      install_mc
      ;;
    "Discord" | "NodeJS")
      echo "Unsupported at the moment."
      exit
      ;;
    *)
      echo "Invalid server type."
      exit
      break
      ;;
    esac
  done
}

launch_server() {
  # Using Aikars flags.
  java -Xms1024M $STARTUP_FLAGS -jar server.jar nogui
}

FILE=server.jar

display_motd
if [ ! -f "$FILE" ]; then
  sleep 5
  select_server
else
  launch_server
fi
