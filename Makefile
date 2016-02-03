
build:
	docker build -t sshd .


run:
	docker run -it --rm \
        	   -v /etc/localtime:/etc/localtime:ro \
	           -v /home/core/sshd/src/tmp:/tmp \
                   -P  \
        	   mail bash

.PHONY: build run

