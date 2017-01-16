#!/bin/bash -e

IMAGE_NAME=scortum/sshd
VERSION=latest
DOCKER_CONTAINER_NAME=scortum-sshd


cat > /etc/default/${DOCKER_CONTAINER_NAME} << EOF
DOCKER_IMAGE=${IMAGE_NAME}:${VERSION}
DOCKER_CONTAINER_NAME=${DOCKER_CONTAINER_NAME}
LOCAL_DIR=/data/${DOCKER_CONTAINER_NAME}
DOCKER_HOSTNAME=docker.phon.name
EOF


cat > /lib/systemd/system/${DOCKER_CONTAINER_NAME}.service << EOF
[Unit]
Description=Scortum SSHD
Requires=docker.service
After=docker.service

[Service]
Restart=on-failure
RestartSec=10
TimeoutStartSec=0
EnvironmentFile=/etc/default/${DOCKER_CONTAINER_NAME}
ExecStartPre=-/usr/bin/docker kill \${DOCKER_CONTAINER_NAME}
ExecStartPre=-/usr/bin/docker rm \${DOCKER_CONTAINER_NAME}
ExecStartPre=/usr/bin/docker pull \${DOCKER_IMAGE}
ExecStart=/usr/bin/docker run --name \${DOCKER_CONTAINER_NAME}      \
                              -h \${DOCKER_HOSTNAME}                \
                              -p 22:22                              \
                              -p 5190:5190                          \
                              -p 6667:6667                          \
                              -p 6668:6668                          \
                              -p 6668:6668                          \
                              -p 9002:9002                          \
                              -v \${LOCAL_DIR}/home:/home           \
                              -v \${LOCAL_DIR}/etc/ssh:/etc/ssh     \
                              -v /etc/localtime:/etc/localtime:ro   \
                              \${DOCKER_IMAGE}
ExecStop=/usr/bin/docker stop --time=10 \${DOCKER_CONTAINER_NAME} 

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

