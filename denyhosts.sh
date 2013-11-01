for i in `host -t TXT networks srv.bastun.net | awk '{print $4}' | grep \" | cut -f 2 -d\"` ; do
	INFO=`ipcalc $i | grep HostM`
	real=`echo $INFO | awk '{print $2}' | cut -f 1,2,3 -d.`
	min=`echo $INFO | awk '{print $2}' | cut -f 4 -d.`
	max=`echo $INFO | awk '{print $6}' | cut -f 4 -d.`
	echo $real.[$min-$max]
done > /var/lib/denyhosts/allowed-hosts
