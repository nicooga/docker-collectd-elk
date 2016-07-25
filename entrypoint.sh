#!/bin/bash

set -eu

COLLECTD_CONF=/etc/collectd/collectd.conf

: ${COLLECTD_HOST:=}
if [ -z "${COLLECTD_HOST}" -a -e "/host/hostname" ]; then
    COLLECTD_HOST=$(cat /host/hostname);
fi
if [ -n "$COLLECTD_HOST" ]; then
    sed -i -e "s/# @COLLECTD_HOST@/Hostname ${COLLECTD_HOST//-/}/g" $COLLECTD_CONF
fi

: ${COLLECTD_INTERVAL_SECONDS:=10}
sed -i -e "s/# @COLLECTD_INTERVAL_SECONDS@/Interval $COLLECTD_INTERVAL_SECONDS/g" $COLLECTD_CONF

if [ ! -d /mnt/oldproc -a -d /host/proc ]; then
    umount /proc
    mount -o bind /host/proc /proc
    mkdir -p /mnt/oldproc
    mount -t proc none /mnt/oldproc
fi

if [ -z "$@" ]; then
    exec /usr/sbin/collectd -C $COLLECTD_CONF -f
fi

exec "$@"
