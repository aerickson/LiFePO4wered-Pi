#!/usr/bin/env bash

set -e

HOST=$1

if [[ -z "$HOST" ]]; then
  echo "FATAL: Please specify a host!"
  exit 1
fi

# TODO: check that build dir exists

scp autostart.sh root@$HOST:/storage/.config/autostart.sh
scp ../build/DAEMON/lifepo4wered-daemon root@$HOST:/usr/sbin/
scp ../build/CLI/lifepo4wered-cli root@$HOST:/usr/sbin

ssh root@$HOST "chmod 755 /usr/sbin/lifepo4wered*"
