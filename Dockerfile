FROM        ubuntu:20.04

LABEL       author="dxqt" maintainer="hi@dxqt.lol"

ENV TZ=Asia/Bangkok HOST_NAME=AlacticHost
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y \
 && apt-get install -y curl ca-certificates figlet openssl git tar sqlite fontconfig tzdata iproute2

RUN addgroup --gid 2983 container && useradd -m -u 999 -d /home/container -g container -s /bin/bash container

RUN chmod 777 /tmp && chown container:container /tmp

ENV  USER=container HOME=/home/container
USER container
 
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
COPY        ./dev.sh /dev.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
