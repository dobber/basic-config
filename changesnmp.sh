#!/bin/bash
PS3='Please select your datacenter: '
options=("SisGroup, Sidney, Australia" "Telepoint, Sofia, Bulgaria" "Ancient Media, Sofia, Bulgaria" "Pulsant, Maidenhead, UK" "SteadFast, Chicago, USA" "Unknown" "Type in")
select opt in "${options[@]}"
do case $opt in
	"${options[0]}")
		echo "Setting ${options[0]}"
		DATACENTER=${options[0]}
		break
		;;
	"${options[1]}")
		echo "Setting ${options[1]}"
		DATACENTER=${options[1]}
		break
		;;
	"${options[2]}")
		echo "Setting ${options[2]}"
		DATACENTER=${options[2]}
		break
		;;
	"${options[3]}")
		echo "Setting ${options[3]}"
		DATACENTER=${options[3]}
		break
		;;
	"${options[4]}")
		echo "Setting ${options[4]}"
		DATACENTER=${options[4]}
		break
		;;
	"${options[5]}")
		echo "Setting ${options[5]}"
		DATACENTER=${options[5]}
		break
		;;
	"${options[6]}")
		echo "Setting ${options[6]}"
		read DATACENTER
		break
		;;
	*) echo invalid option;;
	esac
done

PASSWD=`dd if=/dev/urandom count=1 2> /dev/null | md5sum | cut -c-26`
sed -e s/PAROLA/"${PASSWD}"/g snmpd.conf > snmpd.conf-new
sed -ie s/DATACENTER/"${DATACENTER}"/g snmpd.conf-new
rm snmpd.conf-newe
