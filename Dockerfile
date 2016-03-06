FROM ubuntu
MAINTAINER Marcus & Alex

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
# disable PAM
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN apt-get install -y vim emacs irssi screen rtorrent curl w3m 

ADD src/add-users.sh  /add-users.sh
ADD src/run.sh        /run.sh


EXPOSE 22
CMD "/run.sh"
    
