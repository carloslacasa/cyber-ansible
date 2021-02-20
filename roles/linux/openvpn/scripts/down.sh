#!/bin/bash

BR=$1
ETHDEV=$2
TAPDEV=$3

## desactivacion de bridge para TAP
/sbin/brctl delif $BR $TAPDEV
/sbin/ip link set "$ETHDEV" promisc off
/sbin/ip link set "$TAPDEV" down

## Local network restrictions (L2 filter)
#/sbin/ebtables -t filter -D FORWARD -p IPV4 -i tap0 -o ens3 --ip-protocol tcp --ip-src 192.168.1.80 --ip-dst 192.168.1.24 --ip-destination-port 80 -j ACCEPT
#/sbin/ebtables -t filter -D FORWARD -p IPV4 -i tap0 -o ens3 --ip-protocol tcp --ip-src 192.168.1.81 --ip-dst 192.168.1.24 --ip-destination-port 80 -j ACCEPT
### Bloqueo
#/sbin/ebtables -t filter -D FORWARD -p IPV4 -i tap0 -o ens3 --ip-dst 192.168.1.24 -j DROP

## Remote network restrictions (L3 filter)
#/sbin/iptables -D FORWARD -p tcp -i br0 -o br0 -s 192.168.1.80 -d 192.168.2.28 --sport 1024: --dport 80 -j ACCEPT
#/sbin/iptables -D FORWARD -p tcp -o br0 -i br0 -d 192.168.1.80 -s 192.168.2.28 --dport 1024: --sport 80 -j ACCEPT
### Bloqueo
#/sbin/iptables -D FORWARD -p all -i br0 -o br0 -s 192.168.1.0/24 -d 192.168.2.28 -j REJECT
#/sbin/iptables -D FORWARD -p all -o br0 -i br0 -d 192.168.1.0/24 -s 192.168.2.28 -j REJECT
