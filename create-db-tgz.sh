#!/bin/bash


start_db(){
  echo 'export PUBLIC_IP=1.1.1.1'>Profile
  cbd startdb
  cbd migrate cbdb up
  if cbd migrate cbdb status|grep "MyBatis Migrations SUCCESS" ; then
      echo Migration: OK
  else
      echo Migration: ERROR
      exit 1
  fi
}

db_backup() {
    local ver=$(cbd env export|grep DOCKER_TAG_PERISCOPE|sed "s/.*=//")

    mkdir -p release
    docker exec  cbreak_pcdb_1 tar cz -C /var/lib/postgresql/data . > release/pcdb-${ver}.tgz
}

release() {
    gh-release create sequenceiq/docker-pcdb 0.5.2
}

main() {
    start_db
    db_backup
}

[[ "$0" ==  "$BASH_SOURCE" ]] && main "$@"
