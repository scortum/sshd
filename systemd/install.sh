#!/bin/bash -e

IMAGE_NAME=scortum/sshd
VERSION=latest
DOCKER_CONTAINER_NAME=scortum-sshd


cat > /etc/default/${DOCKER_CONTAINER_NAME} << EOF
DOCKER_IMAGE=${IMAGE_NAME}:${VERSION}
DOCKER_CONTAINER_NAME=${DOCKER_CONTAINER_NAME}
LOCAL_DIR=/data/${DOCKER_CONTAINER_NAME}
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
                              -p 2222:22                            \
                              -v \${LOCAL_DIR}/home:/home           \
                              -v \${LOCAL_DIR}/etc/ssh:/etc/ssh     \
                              -v /etc/localtime:/etc/localtime:ro   \
                              \${DOCKER_IMAGE}
ExecStop=/usr/bin/docker stop --time=10 \${DOCKER_CONTAINER_NAME} 

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

