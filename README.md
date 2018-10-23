# SSH in Docker

Container providing a ssh service. Not alway a good idea ;-)


[![dockerhub](https://img.shields.io/badge/docker-scortum/sshd-blue.svg)](https://hub.docker.com/r/scortum/sshd/)
[![github](https://img.shields.io/badge/github-scortum/sshd-lightgrey.svg)](https://github.com/scortum/sshd)
[![](https://images.microbadger.com/badges/image/scortum/sshd.svg)](https://microbadger.com/images/scortum/sshd "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/scortum/sshd.svg)](https://microbadger.com/images/scortum/sshd "Get your own version badge on microbadger.com")



## Links

Inspired by:
* https://hub.docker.com/r/rastasheep/ubuntu-sshd/
* https://github.com/apk/ubik


Others:

* [Make every container available via ssh](https://github.com/jeroenpeeters/docker-ssh)

* [Container that imports user keys from github profiles](https://github.com/million12/docker-php-app-ssh)

  * script can be found [here](https://github.com/million12/docker-php-app-ssh/blob/master/container-files/github-keys.sh)



* or pass the key via first parameter like [here](https://github.com/robvanmieghem/docker-sshd/blob/master/entry.sh)



## Code

    $ docker run -d -P --name test scortum/sshd
    $ docker port test 22
    0.0.0.0:49154

    $ ssh root@localhost -p 49154
    root@test $

