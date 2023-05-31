FROM debian:stable

RUN apt-get update \ 
    && apt-get -y upgrade \
    && apt-get -y install curl wget unzip git tar bash figlet sudo \
    && useradd -ms /bin/bash container \
    && usermod -aG sudo container \ 
    && chmod 4755 /usr/bin/sudo

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./update.sh /update.sh

CMD ["/bin/bash", "/entrypoint.sh"]