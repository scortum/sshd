FROM ubuntu:18.04
LABEL maintainers="Marcus & Alex"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
 && apt-get -y upgrade \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update                           \
 && apt-get install -y  -q                   \
                    --no-install-recommends  \
                    curl                     \
                    emacs                    \
                    irssi                    \
                    locales                  \
                    openssh-server           \
                    screen                   \
                    rtorrent                 \
                    tmux                     \
                    vim                      \
                    w3m                      \
 && apt-get clean                            \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN BEFORE='session\s*required\s*pam_loginuid.so'    \
 && AFTER='session optional pam_loginuid.so'         \
 && sed "s@${BEFORE}@${AFTER}@g" -i /etc/pam.d/sshd

RUN locale-gen de_DE.UTF-8 \ 
 && locale-gen en_US.UTF-8 \
 && dpkg-reconfigure locales

ADD src/*.sh  /root/

EXPOSE 22 5190 6667 6668 6669 9002

CMD ["/root/run.sh"]
    
