#!/bin/bash

snmpcommunity=`grep com2sec /etc/snmp/snmpd.conf | grep 198.23.53.46/32 | awk '{print $4}'`

echo "Add to observium:"
echo "ssh root@observium \"(cd /opt/observium/ && ./addhost.php $HOSTNAME $snmpcommunity v2c)\""

echo "Add to servman:"
echo "		edit server, add snmphost, add snmpcommunity, activate rsbackup + snmp, check for ips and disks"
echo "Add nagios:"
echo "		edit nagios, set profile"
echo "Add backup:"
echo "		set backup"
