#!/bin/bash -e


error() {
  local parent_lineno="$1"
  local message="$2"
  local code="${3:-1}"
  if [[ -n "$message" ]] ; then
    echo "Error on or near line ${parent_lineno}: ${message}; exiting with status ${code}"
  else
    echo "Error on or near line ${parent_lineno}; exiting with status ${code}"
  fi
  exit "${code}"
}
trap 'error ${LINENO}' ERR


build() {
  docker build -t sshd .
}

rebuild() {
  docker build --no-cache -t sshd .
}

run() {
  docker stop sshd || true
  docker rm sshd || true
  docker run -d --name sshd \
             -v /etc/localtime:/etc/localtime:ro \
             -v ~/sshd/src/tmp:/tmp \
             -v ~/data-lamp.scortum.com:/data \
             -p 6999:6999  \
             sshd
}

enter() {
  docker exec -it sshd bash
}

bash() {
  docker run -it --rm \
             -v /etc/localtime:/etc/localtime:ro \
             -v ~/sshd/src/tmp:/tmp \
             -v ~/data-lamp.scortum.com:/data \
             -p 6999:6999  \
             sshd bash
}


clean() {
  # http://www.projectatomic.io/blog/2015/07/what-are-docker-none-none-images/
  local DANGLING_IMAGES=$(docker images -f "dangling=true" -q)
  [[ ${DANGLING_IMAGES} ]] && docker rmi ${DANGLING_IMAGES}
  local STOPPED_CONTAINERS=$(docker ps -a -q)
  [[ ${STOPPED_CONTAINERS} ]] && docker rm ${STOPPED_CONTAINERS}
}


security-check() {
  # https://github.com/docker/docker-bench-security
  docker run -it --net host --pid host --cap-add audit_control \
    -v /var/lib:/var/lib \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /usr/lib/systemd:/usr/lib/systemd \
    -v /etc:/etc --label docker_bench_security \
    docker/docker-bench-security
}

help() {
  declare -F
}

if [[ $@ ]]; then
 "$@"
else
  build
fi

