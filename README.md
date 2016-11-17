## sshd

[![](https://images.microbadger.com/badges/image/scortum/sshd.svg)](https://microbadger.com/images/scortum/sshd "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/scortum/sshd.svg)](https://microbadger.com/images/scortum/sshd "Get your own version badge on microbadger.com")


From https://hub.docker.com/r/rastasheep/ubuntu-sshd/

    $ docker run -d -P --name test scortum/sshd
    $ docker port test 22
    0.0.0.0:49154

    $ ssh root@localhost -p 49154
    root@test $

