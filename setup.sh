#!/bin/bash
[ -x ~/bin ] || mkdir ~/bin
cd ~/bin

function byrust(){
  USER=$1
  REPO=$2
  V=$3
  APP=$4
  POSTFIX=i686-unknown-linux-musl
  PACK=${REPO}-${V}-${POSTFIX}
  EXT=tar.gz
  echo curl -LO https://github.com/${USER}/${REPO}/releases/download/${V}/${PACK}.${EXT}
  curl -LO https://github.com/${USER}/${REPO}/releases/download/${V}/${PACK}.${EXT}
  tar xzf ${PACK}.${EXT}
  mv ${PACK}/${APP} ${APP}
  rm ${PACK}.${EXT}
  rm -rf ${PACK}
}

function fzf_install(){
  V=$1
  PACK=fzf-${V}-linux_amd64
  EXT=tgz
  curl -LO https://github.com/junegunn/fzf-bin/releases/download/${V}/${PACK}.${EXT}
  tar xzf fzf-${V}-linux_amd64.tgz
  rm ${PACK}.${EXT}
}

function bygolang(){
  USER=$1
  REPO=$2
  V=$3
  PACK=${REPO}_${V}_linux_amd64.zip
  curl -LO https://github.com/${USER}/${REPO}/releases/download/${V}/${PACK}
  unzip ${PACK}
  rm ${PACK}
}

# ripgrep
VERSION_RIPGREP=11.0.2
which rg >/dev/null || byrust BurntSushi ripgrep $VERSION_RIPGREP rg

# fd
VERSION_FD=v7.2.0
which fd >/dev/null || byrust sharkdp fd $VERSION_FD fd

# godit
which godit >/dev/null || docker run --rm -it --name golang -v $(pwd):/cwd -w /cwd golang:1.11 bash -c 'go get github.com/nsf/godit && mv /go/bin/godit /cwd/'

# # micro
# which micro >/dev/null || curl https://getmic.ro | bash

# 9t
VERSION_9t=0.0.2
which 9t >/dev/null || bygolang gongo 9t $VERSION_9t

# fzf
VERSION_fzf=0.18.0
which fzf >/dev/null || fzf_install $VERSION_fzf
