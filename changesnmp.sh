#!/bin/bash
PASSWD=`dd if=/dev/urandom count=1 2> /dev/null | md5sum | cut -c-26`
sed -ie s/PAROLA/$PASSWD/ snmpd.conf
