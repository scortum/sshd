FROM ubuntu:14.04
MAINTAINER Marcus & Alex

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get -y upgrade \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y vim emacs irssi screen rtorrent curl w3m \
    && apt-get install -y openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ADD src/add-users.sh                /root/add-users.sh
ADD src/create-new-host-keys.sh     /root/create-new-host-keys.sh
ADD src/cleanup.sh                  /root/cleanup.sh
ADD src/run.sh                      /root/run.sh

EXPOSE 22
CMD "/root/run.sh"
    
