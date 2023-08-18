#!/bin/bash
args=("$@")


function init_all() {
  usermod -a -G sudo hadoop
  echo 'hadoop:gohdp' | chpasswd
  init_ssh

  mkdir -p ${HDFS_DATA_DIR}
}


function init_ssh () {
  ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
  chmod 0600 ~/.ssh/authorized_keys
}


function run_container() {

  /etc/init.d/ssh start
  # sudo -u hadoop -E bash /opt/hadoop/sbin/start-dfs.sh

}


case $1 in
  init)
    init_all "${args[@]:1}"
    ;;
  *)
  run_container
esac