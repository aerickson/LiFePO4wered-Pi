#!/usr/bin/env bash

set -e

HOST=$1

if [[ -z "$HOST" ]]; then
  echo "FATAL: Please specify a host!"
  exit 1
fi

# TODO: check that build dir exists

ROOT_DIR="/storage/LiFePo4wered"
ssh root@$HOST "mkdir -p $ROOT_DIR"

scp autostart.sh root@$HOST:/storage/.config/autostart.sh
scp ../build/lifepo4wered-daemon root@$HOST:$ROOT_DIR/
scp ../build/lifepo4wered-cli root@$HOST:$ROOT_DIR/


ssh root@$HOST "chmod 755 /storage/.config/autostart.sh"
ssh root@$HOST "chmod 755 $ROOT_DIR/lifepo4wered*"
