#!/bin/bash
set -o nounset
set -o errexit
set -e

#######################################
export REPO_URL="https://github.com/asaglimbeni/VPHOP_NMS2ANS"
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

# Global Dependencies
requires() {
  cat << EOF
Script requires:
 - wget and tar; or
 - git

Please file a bug report at $REPO_URL/issues
Please detail your operating system type, version and any other relevant details
EOF
  exit 1
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
else
    alias pkgclean='sudo yum -y clean'
    alias pkgpurge='sudo rpm -e'
    alias pkgsearch='sudo yum search'
    alias pkgupdate='sudo yum update'
    alias pkgremove='sudo yum -y remove'
    alias pkgupgrade='sudo yum -y upgrade'
    alias pkginstall='sudo yum -y install'
    alias pkgautoremove='sudo yum -y autoremove'
    alias pkgdist-upgrade=''
fi
#######################################
# Check weather script is run as root
if [[ $EUID -ne 0 ]]; then
  err "Script must be run as root."
  exit 1
fi
#######################################
# Check if repository is already installed
sudo mkdir -p /webapp
cd /webapp
if [ -d REPO_DIR ]; then
  err "You already have $REPO_NAME installed."
  err "You'll need to remove $REPO_NAME if you want to continue installing"
  exit 1
fi

# Download Repository
clone_repo() {
    if exists git; then
      log "Cloning ${REPO_NAME} Repository..."
      git clone $REPO_URL $REPO_NAME-master
    elif $(exists wget) && $(exists tar); then
      log "Downloading ${REPO_NAME} tarball..."
      wget -Nq --no-check-certificate $REPO_URL/archive/master.tar.gz -O /webapp/$REPO_NAME.tar.gz
      log "Extracting ${REPO_NAME} tarball..."
      tar xf $REPO_NAME.tar.gz
    else
        log "Installing installed packages: wget, tar"
        pkginstall wget tar
        clone_repo
    fi
}
#######################################
log "Provisioning $REPO_NAME..."
CWD=$PWD
clone_repo
cd $REPO_NAME-master
log "Provisioning ${REPO_NAME}"
$REPO_DIR/manage/provision.sh 2>&1 | tee ~/$REPO_NAME-install.log
cd $CWD
log "$REPO_NAME provisioning complete."
#######################################
