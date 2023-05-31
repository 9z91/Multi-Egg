FROM debian:stable

RUN apt-get update\
    && apt-get -y install curl wget unzip git tar bash figlet \
    && useradd -ms /bin/bash container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./update.sh /update.sh

CMD ["/bin/bash", "/entrypoint.sh"]