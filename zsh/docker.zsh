# -----------------------------------------------------------------------------
# zsh docker
# -----------------------------------------------------------------------------
(( ${+commands[docker]} )) || return

# Aliases
# -----------------------------------------------------------------------------

docker-clean() {
  emulate -L zsh

  typeset -a _containers _images _volumes
  _containers=($(docker ps --filter status=exited -q 2>/dev/null))
  _images=($(docker images --filter dangling=true -q 2>/dev/null))
  _volumes=($(docker volume ls --filter dangling=true -q 2>/dev/null))

  if (( $#_containers > 0 )); then
    echo "Deleting stale containers..."
    command docker rm "${_containers[@]}"
  fi
  if (( $#_images > 0 )); then
    echo "Deleting stale images..."
    command docker rmi "${_images[@]}"
  fi
  if (( $#_volumes > 0 )); then
    echo "Deleting stale volumes..."
    command docker volume rm "${_volumes[@]}"
  fi
}

docker-nuke() {
  emulate -L zsh

  typeset -a _containers
  _containers=($(docker ps -aq))

  if (( $#_containers > 0 )); then
    echo "Stopping all containers..."
    command docker stop "${_containers[@]}"
    command docker wait "${_containers[@]}"

    echo "Deleting all containers..."
    command docker rm "${_containers[@]}"
  fi
}

if [[ $(uname -s) == "Darwin" ]]; then
  docker-compact-disk() {
    cd ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux || return
    /Applications/Docker.app/Contents/MacOS/qemu-img convert -p -O qcow2 Docker.qcow2 Docker2.qcow2
    mv Docker2.qcow2 Docker.qcow2
  }

  docker-screen() {
    screen -D -R -S moby ${HOME}/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty
  }
fi

# -----------------------------------------------------------------------------
# vim:ft=zsh
