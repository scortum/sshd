FROM ubuntu:14.04
MAINTAINER Marcus & Alex

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get -y upgrade \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y  \
                          vim            \
                          emacs          \
                          irssi          \
                          screen         \
                          rtorrent       \
                          curl           \
                          w3m            \
                          openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN BEFORE='session\s*required\s*pam_loginuid.so'    \
 && AFTER='session optional pam_loginuid.so'         \
 && sed "s@${BEFORE}@${AFTER}@g" -i /etc/pam.d/sshd

RUN locale-gen de_DE.UTF-8 \ 
 && locale-gen en_US.UTF-8 \
 && dpkg-reconfigure locales

ADD src/add-users.sh                \
    src/create-new-host-keys.sh     \
    src/cleanup.sh                  \
    src/run.sh                      \
    /root/

EXPOSE 22
CMD "/root/run.sh"
    
