squeeze-backports:
	cp -a apt/squeeze-backports /etc/apt/sources.list
	apt-get update
	apt-get -y install re2c xfsdump xfslibs-dev xfsprogs libattr1-dev apticron nano nmap uuid bind9-host ntp ntpdate ethstatus sqlite3 libsqlite3-dev hdparm debian-keyring g++-multilib dh-make alien rpm lsof lsscsi sysstat jed jed-common jed-extra bzip2 strace gcc g++ autoconf automake autoconf2.13 autoconf-archive gnu-standards libtool gettext gcc-4.4-locales g++-multilib g++-4.4-multilib gcc-multilib make automake1.9 flex bison gdb gcc-4.4-multilib libmudflap0-4.4-dev libcloog-ppl0 libppl-c2 libppl7 binfmt-support elfutils snmp snmpd apt-file nagios-nrpe-server tcl tk debian-keyring debian-archive-keyring strace traceroute telnet bc sysvinit-utils psmisc libncurses5-dev libmysqlclient-dev mtr git libfuse-dev libfuse2 fuse-utils libxml2-dev libreadline-dev vim-tiny sharutils smartmontools pkg-config fuse-utils libfuse-dev libfuse2 fuseext2 fuse-posixovl libssl-dev tcpdump iptraf screen parted libaio1 libaio-dev links ipcalc snmp-mibs-downloader hddtemp lm-sensors sudo xinetd check-mk-agent
	apt-get -y remove samba bind9
	apt-get -y dist-upgrade
	apt-file update
	dpkg-reconfigure apticron
	cp -a apt/apticron /etc/cron.d/apticron
	apt-get clean

wheezy-backports:
	cp -a apt/wheezy-backports /etc/apt/sources.list
	apt-get update
	apt-get -y install re2c xfsdump xfslibs-dev xfsprogs libattr1-dev apticron nano nmap uuid bind9-host ntp ntpdate ethstatus sqlite3 libsqlite3-dev hdparm debian-keyring g++-multilib dh-make alien rpm lsof lsscsi sysstat jed jed-common jed-extra bzip2 strace gcc g++ autoconf automake autoconf2.13 autoconf-archive gnu-standards libtool gettext gcc-4.4-locales g++-multilib g++-4.4-multilib gcc-multilib make automake1.9 flex bison gdb gcc-4.4-multilib libmudflap0-4.4-dev libcloog-ppl0 binfmt-support elfutils snmp snmpd apt-file nagios-nrpe-server tcl tk debian-keyring debian-archive-keyring strace traceroute telnet bc sysvinit-utils psmisc libncurses5-dev libmysqlclient-dev mtr git libfuse-dev libfuse2 fuse-utils libxml2-dev libreadline-dev vim-tiny sharutils smartmontools pkg-config fuse-utils libfuse-dev libfuse2 fuseext2 fuse-posixovl libssl-dev tcpdump iptraf screen parted libaio1 libaio-dev links ipcalc snmp-mibs-downloader hddtemp lm-sensors sudo xinetd check-mk-agent
	apt-get -y dist-upgrade
	apt-file update
	dpkg-reconfigure apticron
	cp -a apt/apticron /etc/cron.d/apticron
	apt-get clean

all:
	cat profile >> /etc/profile
	cp -a bashrc /root/.bashrc
	. /root/.bashrc
	cp -a vim/* /etc/vim/
	cp locale.gen /etc
	locale-gen
	ssh-keygen -t rsa
	echo "/usr/local/lib/" > /etc/ld.so.conf
	ldconfig
	./changesnmp.sh
	cp -a snmpd.conf-new /etc/snmp/snmpd.conf
	/etc/init.d/snmpd restart
	cp -a nrpe.cfg /etc/nagios/nrpe.cfg
	/etc/init.d/nagios-nrpe-server restart
	echo > /etc/motd
	echo > /etc/motd.tail
	rm -fr /etc/cron.daily/man-db /etc/cron.weekly/man-db /etc/cron.daily/mlocate
	cp -a sysstat /etc/default/sysstat
	/etc/init.d/sysstat restart
#	sensors-detect
	cp -a check_mk /etc/xinetd.d/check_mk
	/etc/init.d/xinetd restart
