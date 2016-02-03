
build:
	docker build -t sshd .


run:
	-docker stop sshd-test
	-docker rm sshd-test
	docker run -d --name sshd-test \
        	   -v /etc/localtime:/etc/localtime:ro \
	           -v /home/core/sshd/src/tmp:/tmp \
                   -P  \
        	   sshd

stop:
	-docker stop sshd-test
	-docker rm sshd-test

.PHONY: build run

