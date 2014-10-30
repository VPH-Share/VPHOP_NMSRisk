#!/bin/bash
#######################################
export REPO_URL="https://github.com/VPH-Share/VPHOP_NMSRisk"
export REPO_URL=${REPO_URL%/}         # Remove trailing slash, if any
export REPO_NAME=${REPO_URL##*/}      # Extract Repository name
export REPO_USER=${REPO_URL%/*}       # Extract Repository user
export REPO_DIR=/webapp/$REPO_NAME-master
#######################################
# Error Message
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

log() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&1
}

# Check whether a command exists - returns 0 if it does, 1 if it does not
exists() {
  if $(command -v $1 &>/dev/null); then
    return 0
  else
    return 1
  fi
}

# Package management aliases
OS=$(lsb_release -si)
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
VER=$(lsb_release -sr)
if [ "$OS" == "Ubuntu" ]; then
    alias pkgclean='sudo apt-get -y clean'
    alias pkgpurge='sudo apt-get -y purge'
    alias pkgsearch='sudo apt-get search'
    alias pkgupdate='sudo apt-get update'
    alias pkgremove='sudo apt-get -y remove'
    alias pkgupgrade='sudo apt-get -y upgrade'
    alias pkginstall='sudo apt-get -y install'
    alias pkgautoremove='sudo apt-get -y autoremove'
    alias pkgdist-upgrade='sudo apt-get -y dist-upgrade'
    alias setlocales='sudo locale-gen en_GB en_GB.utf8'
else
    alias pkgclean='sudo yum -y clean'
    alias pkgsearch='sudo yum search'
    alias pkgupdate='sudo yum update'
    alias pkgremove='sudo yum -y remove'
    alias pkgupgrade='sudo yum -y upgrade'
    alias pkginstall='sudo yum -y install'
    alias pkgautoremove='sudo yum -y autoremove'
    alias setlocales='sudo locale-gen en_GB en_GB.utf8'
fi
#######################################
