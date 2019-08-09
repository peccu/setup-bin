#!/bin/bash
[ -x ~/bin ] || mkdir ~/bin
cd ~/bin

function byrust(){
  USER=$1
  REPO=$2
  V=$3
  APP=$4
  POSTFIX=i686-unknown-linux-musl
  echo curl -LO https://github.com/${USER}/${REPO}/releases/download/${V}/${REPO}-${V}-${POSTFIX}.tar.gz
  curl -LO https://github.com/${USER}/${REPO}/releases/download/${V}/${REPO}-${V}-${POSTFIX}.tar.gz
  tar xzf ${REPO}-${V}-${POSTFIX}.tar.gz
  mv ${REPO}-${V}-${POSTFIX}/${APP} ${APP}
  rm ${REPO}-${V}-${POSTFIX}.tar.gz
  rm -rf ${REPO}-${V}-${POSTFIX}
}

function bygolang(){
  USER=$1
  REPO=$2
  V=$3
  curl -LO https://github.com/${USER}/${REPO}/releases/download/${V}/${REPO}_${V}_linux_amd64.zip
  unzip ${REPO}_${V}_linux_amd64.zip
  rm ${REPO}_${V}_linux_amd64.zip
}

# ripgrep
VERSION_RIPGREP=11.0.2
byrust BurntSushi ripgrep $VERSION_RIPGREP rg

# fd
VERSION_FD=v7.2.0
byrust sharkdp fd $VERSION_FD fd

# godit
docker run --rm -it --name golang -v $(pwd):/cwd -w /cwd golang:1.11 bash -c 'go get github.com/nsf/godit && mv /go/bin/godit /cwd/'

# micro
curl https://getmic.ro | bash

# 9t
VERSION_9t=0.0.2
bygolang gongo 9t $VERSION_9t
