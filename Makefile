
build:
	docker build -t sshd .


run:
	-docker stop sshd-test
	-docker rm sshd-test
	docker run -d --name sshd-test \
        	   -v /etc/localtime:/etc/localtime:ro \
	           -v /home/core/sshd/src/tmp:/tmp \
                   -p 2222:22  \
        	   sshd

bash:
	docker run -it --rm \
        	   -v /etc/localtime:/etc/localtime:ro \
	           -v ~/sshd/src/tmp:/tmp \
                   -p 2222:22  \
        	   sshd bash


stop:
	-docker stop sshd-test
	-docker rm sshd-test

.PHONY: build run

