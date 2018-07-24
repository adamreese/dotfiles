#!/usr/bin/env bash
set -euo pipefail

# Download an OSX binary minikube
# https://github.com/kubernetes/minikube/releases
# Put it somewhere that you can run it from: /usr/local/bin/minikube && chmod +x /usr/local/bin/minikube

# minikube-darwin-amd64

echo
echo "ᴍɪɴɪᴋᴜʙᴇ :: installing latest minikube"
echo

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 &&
  chmod +x minikube &&
  sudo mv minikube /usr/local/bin/

minikube version

# Download Docker Machine Hyperkit Driver
# docker-machine-driver-hyperkit

echo
echo "ᴍɪɴɪᴋᴜʙᴇ :: installing hyperkit driver"
echo

curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit &&
  chmod +x docker-machine-driver-hyperkit &&
  sudo mv docker-machine-driver-hyperkit /usr/local/bin/ &&
  sudo chown root:wheel /usr/local/bin/docker-machine-driver-hyperkit &&
  sudo chmod u+s /usr/local/bin/docker-machine-driver-hyperkit
