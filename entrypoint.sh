#!/bin/bash

set -eu

COLLECTD_CONF=/etc/collectd/collectd.conf

: ${COLLECTD_HOST:=}
# if COLLECTD_HOST not already set in the container's environment
if [ -z "${COLLECTD_HOST}" ]; then
    # if /etc/hostname is volume mounted in, then use that
    if [ -f "/host/hostname" ]; then
        COLLECTD_HOST=$(cat /host/hostname);
    # else if /proc/sys/kernel/hostname is volume mounted in, then use that
    elif [ -f "/host/proc/sys/kernel/hostname" ]; then
        COLLECTD_HOST=$(cat /host/proc/sys/kernel/hostname);
    fi
fi
# after all that, if COLLECTD_HOST is finally set, then sed up the config
if [ -n "$COLLECTD_HOST" ]; then
    sed -i -e "s/# @COLLECTD_HOST@/Hostname ${COLLECTD_HOST//-/}/g" $COLLECTD_CONF
fi

# default collectd interval to 10s; overriden using COLLECTD_INTERVAL_SECONDS
: ${COLLECTD_INTERVAL_SECONDS:=10}
sed -i -e "s/# @COLLECTD_INTERVAL_SECONDS@/Interval $COLLECTD_INTERVAL_SECONDS/g" $COLLECTD_CONF

if [ ! -d /mnt/oldproc -a -d /host/proc ]; then
    umount /proc
    mount -o bind /host/proc /proc
    mkdir -p /mnt/oldproc
    mount -t proc none /mnt/oldproc
fi

# if no command specified, start collectd
if [ -z "$@" ]; then
    exec /usr/sbin/collectd -C $COLLECTD_CONF -f
fi

# otherwise run the command
exec "$@"
