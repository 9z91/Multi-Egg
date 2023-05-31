#!/bin/bash

HOST_NAME=MultiEgg

PAPER_1_8=https://api.papermc.io/v2/projects/paper/versions/1.8.8/builds/445/downloads/paper-1.8.8-445.jar
PAPER_1_12_2=https://api.papermc.io/v2/projects/paper/versions/1.12.2/builds/1620/downloads/paper-1.12.2-1620.jar
PAPER_1_16_5=https://api.papermc.io/v2/projects/paper/versions/1.16.5/builds/794/downloads/paper-1.16.5-794.jar
PAPER_1_18_2=https://api.papermc.io/v2/projects/paper/versions/1.18.2/builds/388/downloads/paper-1.18.2-388.jar
PAPER_1_19_4=https://api.papermc.io/v2/projects/paper/versions/1.19.4/builds/542/downloads/paper-1.19.4-542.jar

STARTUP_FLAGS=-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true 

function displayMotd {
    echo -e "\033c"
    echo "
==========================================================================

    "  
    
    figlet -l $HOST_NAME
    
    echo "

==========================================================================

    " 
}

function installMCServer {
  echo "Which version of Minecraft?"
  select version in 1.8 1.12 1.16.5 1.19.4
  do
    case $version in
      "1.8")
        installJavaAndPaper 8
      ;;
      "1.12")
        installJavaAndPaper 11
      ;;
      "1.16.5")
        installJavaAndPaper 16
      ;;
      "1.19.4")
        installJavaAndPaper 17
      ;;
      "latest")
        installJavaAndPaper 17
      ;;
      *)
        echo "Invalid server version."
        exit
    break
    ;;
    esac
  done
}

function installJavaAndPaper() { 
  apt update
  case $1 in
    8)
      # JDK 8
      apt install -y default-jdk
      # Paper 1.8.8
      curl -o server.jar $PAPER_1_8_8
      ;;
    11)
      # JDK 11
      echo 'deb http://ftp.debian.org/debian stretch-backports main' | sudo tee /etc/apt/sources.list.d/stretch-backports.list
      apt update
      apt install -y openjdk-11-jdk
      # Paper 1.12.2
      curl -o server.jar $PAPER_1_12_2
      ;;
    16)
      # JDK 16
      add-apt-repository ppa:linuxuprising/java
      apt update
      apt install -y oracle-java16-installer
      # Paper 1.16.5
      curl -o server.jar $PAPER_1_16_5
      ;;
    17)
      # JDK 17
      wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb
      apt install -y ./jdk-17_linux-x64_bin.deb
      export JAVA_HOME=/usr/lib/jvm/jdk-17/
      export PATH=\$PATH:\$JAVA_HOME/bin
      # Paper 1.19.4
      curl -o server.jar $PAPER_1_19_4
      ;;
    *)
      echo -n "Invalid JRE version."
      ;;
  esac
  java -version
  exit
}

function selectServerTypes {
  echo "Which platform are you gonna use?"
  select type in Minecraft Discord NodeJS
  do
  case $type in
    "Minecraft")
      installMCServer
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

function launchServer {
  # Using Aikars flags.
  java -Xms1024M $STARTUP_FLAGS -jar server.jar nogui
}

FILE=eula.txt

if [ ! -f "$FILE" ]
then
    displayMotd
sleep 5
selectServerTypes
else
displayMotd
if [ -f BungeeCord.jar ]; then
  java -Xms512M -Xmx512M -jar BungeeCord.jar
else
  launchServer
fi
fi
