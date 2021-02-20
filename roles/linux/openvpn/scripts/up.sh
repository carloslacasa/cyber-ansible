#!/bin/bash

BR=$1
ETHDEV=$2
TAPDEV=$3

## Activacion de bridge para TAP
/sbin/ip link set "$TAPDEV" up
/sbin/ip link set "$ETHDEV" promisc on
/sbin/brctl addif $BR $TAPDEV

## Local network restrictions (L2 filter)
### Exceptions
#/sbin/ebtables -t filter -A FORWARD -p IPV4 -i tap0 -o ens3 --ip-protocol tcp --ip-src 192.168.1.80 --ip-dst 192.168.1.24 --ip-destination-port 80 -j ACCEPT
#/sbin/ebtables -t filter -A FORWARD -p IPV4 -i tap0 -o ens3 --ip-protocol tcp --ip-src 192.168.1.81 --ip-dst 192.168.1.24 --ip-destination-port 80 -j ACCEPT
### Restricted traffic
#/sbin/ebtables -t filter -A FORWARD -p IPV4 -i tap0 -o ens3 --ip-dst 192.168.1.24 -j DROP

## Remote network restrictions (L3 filter)
#/sbin/iptables -A FORWARD -p tcp -i br0 -o br0 -s 192.168.1.80 -d 192.168.2.28 --sport 1024: --dport 80 -j ACCEPT
#/sbin/iptables -A FORWARD -p tcp -o br0 -i br0 -d 192.168.1.80 -s 192.168.2.28 --dport 1024: --sport 80 -j ACCEPT
### Restricted traffic
#/sbin/iptables -A FORWARD -p all -i br0 -o br0 -s 192.168.1.0/24 -d 192.168.2.28 -j REJECT
#/sbin/iptables -A FORWARD -p all -o br0 -i br0 -d 192.168.1.0/24 -s 192.168.2.28 -j REJECT
