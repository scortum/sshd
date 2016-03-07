FROM ubuntu
MAINTAINER Marcus & Alex

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
# disable PAM
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


RUN apt-get install -y vim emacs irssi screen rtorrent curl w3m 

ADD src/add-users.sh                /add-users.sh
ADD src/run.sh                      /run.sh
ADD src/create-new-host-keys.sh     /create-new-host-keys.sh


EXPOSE 22
CMD "/run.sh"
    
