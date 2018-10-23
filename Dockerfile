FROM apky/ubik AS apky-ubik

FROM ubuntu:18.04
LABEL maintainers="Marcus & Alex"

ENV TERM xterm
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
                    python3                  \
                    python3-pip              \
                    screen                   \
                    rsync                    \
                    rsyslog                  \
                    rtorrent                 \
                    tmux                     \
                    tree                     \
                    vim                      \
                    w3m                      \
                    wget                     \
 && apt-get clean                            \
 && pip3 install sh                          \
 && rm -rf /var/lib/apt/lists/*


# Setup rsyslogd
RUN sed 's/$ModLoad imklog/#$ModLoad imklog/' -i /etc/rsyslog.conf  \
 && sed 's/$KLogPermitNonKernelFacility on/#$KLogPermitNonKernelFacility on/' -i /etc/rsyslog.conf  \
 && sed 's/$FileOwner syslog/$FileOwner root/' -i /etc/rsyslog.conf  \
 && sed 's/$PrivDropToUser syslog/#$PrivDropToUser syslog/' -i /etc/rsyslog.conf  \
 && sed 's/$PrivDropToGroup syslog/#$PrivDropToGroup syslog/' -i /etc/rsyslog.conf  \
 && mv /etc/rsyslog.d/50-default.conf /etc/rsyslog.d/50-default.conf.orig \
 && head -n-5 /etc/rsyslog.d/50-default.conf.orig > /etc/rsyslog.d/50-default.conf


# SSH login fix. Otherwise user is kicked off after login
RUN BEFORE='session\s*required\s*pam_loginuid.so'    \
 && AFTER='session optional pam_loginuid.so'         \
 && sed "s@${BEFORE}@${AFTER}@g" -i /etc/pam.d/sshd
RUN mkdir /var/run/sshd

RUN locale-gen de_DE.UTF-8 \ 
 && locale-gen en_US.UTF-8 \
 && dpkg-reconfigure locales

ADD src/*  /root/
COPY --from=apky-ubik /app/ubik /root/


EXPOSE 22 5190 6667 6668 6669 9002

CMD ["/root/run.sh"]
    
