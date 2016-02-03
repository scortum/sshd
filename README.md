## sshd


From https://hub.docker.com/r/rastasheep/ubuntu-sshd/

    $ docker run -d -P --name test scortum/sshd
    $ docker port test 22
    0.0.0.0:49154

    $ ssh root@localhost -p 49154
    root@test $

