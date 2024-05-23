#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${RALPM_TMP_DIR}" ]]; then
    echo "RALPM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_INSTALL_DIR}" ]]; then
    echo "RALPM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_BIN_DIR}" ]]; then
    echo "RALPM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/RAL0S/baudrate/releases/download/v1.0/baudrate -O $RALPM_TMP_DIR/baudrate
  mv $RALPM_TMP_DIR/baudrate $RALPM_PKG_INSTALL_DIR/baudrate
  chmod +x $RALPM_PKG_INSTALL_DIR/baudrate
  ln -s $RALPM_PKG_INSTALL_DIR/baudrate $RALPM_PKG_BIN_DIR/baudrate
}

uninstall() {
  rm $RALPM_PKG_INSTALL_DIR/baudrate
  rm $RALPM_PKG_BIN_DIR/baudrate
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1