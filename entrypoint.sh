#!/bin/bash

set -eo pipefail

KEEPALIVED_STATE=${KEEPALIVED_STATE:-"BACKUP"}
KEEPALIVED_ROUTER_ID=${KEEPALIVED_ROUTER_ID:-"51"}
KEEPALIVED_INTERFACE=${KEEPALIVED_INTERFACE:-"eth0"}
KEEPALIVED_PRIORITY=${KEEPALIVED_PRIORITY:-"150"}
KEEPALIVED_PASSWORD=${KEEPALIVED_PASSWORD:-"d0ck3r"}

if [ -z "$KEEPALIVED_CONTAINER_NAME" ]; then
  export KEEPALIVED_CONTAINER_NAME='keepalived'
fi

exec docker run -i --rm --name "$KEEPALIVED_CONTAINER_NAME" \
  -v "/var/run/docker.sock:/var/run/docker.sock" \
  --net=host \
  --cap-add=NET_ADMIN \
  --cap-add=NET_BROADCAST \
  --cap-add=NET_RAW \
  -e KEEPALIVED_INTERFACE \
  -e KEEPALIVED_PASSWORD \
  -e KEEPALIVED_PRIORITY \
  -e KEEPALIVED_ROUTER_ID \
  -e KEEPALIVED_UNICAST_PEERS \
  -e KEEPALIVED_VIRTUAL_IPS \
  -e KEEPALIVED_STATE \
  "$1"
