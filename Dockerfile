FROM ubuntu:14.04
MAINTAINER Marcus & Alex

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


RUN apt-get install -y vim emacs irssi screen rtorrent curl w3m 

ADD src/add-users.sh                /add-users.sh
ADD src/run.sh                      /run.sh
ADD src/create-new-host-keys.sh     /create-new-host-keys.sh


RUN echo 'root:supersecret' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config



EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
# CMD "/run.sh"
    
