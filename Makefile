squeeze-backports:
	cp -a apt/squeeze-backports /etc/apt/sources.list
	cp -a apt/pgdg-squeeze.list /etc/apt/sources.list.d/pgdg.list
	wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
	apt-get update
	apt-get -y install re2c xfsdump xfslibs-dev xfsprogs libattr1-dev apticron nano nmap uuid bind9-host ntp ntpdate ethstatus sqlite3 libsqlite3-dev hdparm debian-keyring g++-multilib dh-make alien rpm lsof lsscsi sysstat jed jed-common jed-extra bzip2 strace gcc g++ autoconf automake autoconf2.13 autoconf-archive gnu-standards libtool gettext gcc-4.4-locales g++-multilib g++-4.4-multilib gcc-multilib make automake1.9 flex bison gdb gcc-4.4-multilib libmudflap0-4.4-dev libcloog-ppl0 libppl-c2 libppl7 binfmt-support elfutils snmp snmpd apt-file nagios-nrpe-server tcl tk debian-keyring debian-archive-keyring strace traceroute telnet bc sysvinit-utils psmisc libncurses5-dev libmysqlclient-dev mtr git libfuse-dev libfuse2 fuse-utils libxml2-dev libreadline-dev vim-tiny sharutils smartmontools pkg-config fuse-utils libfuse-dev libfuse2 fuseext2 fuse-posixovl libssl-dev tcpdump iptraf screen parted libaio1 libaio-dev links ipcalc snmp-mibs-downloader hddtemp lm-sensors sudo xinetd check-mk-agent libdbd-pg-perl libdbi-perl libdbd-pgsql python-distutils-extra python-setuptools psutils python-psutil python-psycopg2 libset-crontab-perl libschedule-cron-perl etckeeper vim dstat
	apt-get -y remove samba bind9
	apt-get -y dist-upgrade
	apt-file update
	dpkg-reconfigure apticron
	cp -a apt/apticron /etc/cron.d/apticron
	apt-get clean

wheezy-backports:
	cp -a apt/wheezy-backports /etc/apt/sources.list
	cp -a apt/pgdg-wheezy.list /etc/apt/sources.list.d/pgdg.list
	wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
	apt-get update
	apt-get -y install re2c xfsdump xfslibs-dev xfsprogs libattr1-dev apticron nano nmap uuid bind9-host ntp ntpdate ethstatus sqlite3 libsqlite3-dev hdparm debian-keyring g++-multilib dh-make alien rpm lsof lsscsi sysstat jed jed-common jed-extra bzip2 strace gcc g++ autoconf automake autoconf2.13 autoconf-archive gnu-standards libtool gettext gcc-4.4-locales g++-multilib g++-4.4-multilib gcc-multilib make automake1.9 flex bison gdb gcc-4.4-multilib libmudflap0-4.4-dev libcloog-ppl0 binfmt-support elfutils snmp snmpd apt-file nagios-nrpe-server tcl tk debian-keyring debian-archive-keyring strace traceroute telnet bc sysvinit-utils psmisc libncurses5-dev libmysqlclient-dev mtr git libfuse-dev libfuse2 fuse-utils libxml2-dev libreadline-dev vim-tiny sharutils smartmontools pkg-config fuse-utils libfuse-dev libfuse2 fuseext2 fuse-posixovl libssl-dev tcpdump iptraf screen parted libaio1 libaio-dev links ipcalc snmp-mibs-downloader hddtemp lm-sensors sudo xinetd check-mk-agent libdbd-pg-perl libdbd-pgsql libdbi-perl python-distutils-extra python-setuptools psutils python-psutil python-psycopg2 libset-crontab-perl libschedule-cron-perl etckeeper vim dstat
	apt-get -y dist-upgrade
	apt-file update
	dpkg-reconfigure apticron
	cp -a apt/apticron /etc/cron.d/apticron
	apt-get clean

all:
	git config --global user.name $HOSTNAME
	git config --global user.email admins@amln.net
	# some bash configs
	cat profile >> /etc/profile
	cp -a bashrc /root/.bashrc
	. /root/.bashrc
	cp -a vim/* /etc/vim/
	cp locale.gen /etc
	locale-gen
	# ssh keys
	ssh-keygen -t rsa
	echo "/usr/local/lib/" > /etc/ld.so.conf
	ldconfig
	# exim4 for apticron
	sed -e s/HOSTNAME/`hostname -f`/ update-exim4.conf.conf > /etc/exim4/update-exim4.conf.conf
	/etc/init.d/exim4 restart
	# snmpd for servman, observium
	./changesnmp.sh
	cp -a snmpd.conf-new /etc/snmp/snmpd.conf
	/etc/init.d/snmpd restart
	# nrpe for nagios
	cp -a nrpe.cfg /etc/nagios/nrpe.cfg
	/etc/init.d/nagios-nrpe-server restart
	# even more tweaks
	echo > /etc/motd
	echo > /etc/motd.tail
	rm -fr /etc/cron.daily/man-db /etc/cron.weekly/man-db /etc/cron.daily/mlocate
	# sysstat for process accounting
	cp -a sysstat /etc/default/sysstat
	/etc/init.d/sysstat restart
#	sensors-detect
	# check_mk, hddtemp for observium
	cp -a check_mk /etc/xinetd.d/check_mk
	/etc/init.d/xinetd restart
	cp -a hddtemp /etc/default/hddtemp
	/etc/init.d/hddtemp restart

	git clone https://github.com/dobber/dmesg_timestamp.git
	(cd dmesg_timestamp && ./install)

	git clone git://git.bastun.net/backup.git
	(cd backup && make)

	git clone git://git.bastun.net/dfw.git
	(cd dfw && ./install && /var/lib/dfw/dfw.sh start)
