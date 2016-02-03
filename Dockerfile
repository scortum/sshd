FROM ubuntu
MAINTAINER Marcus & Alex

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config


RUN apt-get install -y vim emacs irssi 


EXPOSE 22


# add users by doing the following on a running container named cont
# docker exec -v ~/credentials:credentials cont add-users.sh

ADD src/add-users.sh /add-users.sh
CMD ["/usr/sbin/sshd" "-D"]
    
