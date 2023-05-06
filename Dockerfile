FROM bash:4.4

FROM debian:unstable

RUN echo 'deb http://deb.debian.org/debian experimental main' > /etc/apt/sources.list.d/experimental.list

LABEL       author="dxqt" maintainer="hi@dxqt.lol"

ENV TZ=Asia/Bangkok HOST_NAME=AlacticHost
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y \
 && apt-get install -y curl ca-certificates figlet openssl git tar fontconfig tzdata iproute2 

RUN addgroup --gid 2983 container && useradd -m -u 999 -d /home/container -g container -s /bin/bash container

RUN chmod 777 /tmp && chown container:container /tmp

USER container
ENV  USER=container 
ENV  HOME=/home/container

WORKDIR     /home/container

COPY        ./dev.sh /dev.sh
COPY        ./entrypoint.sh /entrypoint.sh
 
CMD         ["/bin/bash", "/entrypoint.sh"]
