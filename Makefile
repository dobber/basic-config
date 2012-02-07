squeeze-backports:
	cp -a apt/squeeze-backports /etc/apt/sources.list
	apt-get update
	apt-get install re2c xfsdump xfslibs-dev xfsprogs libattr1-dev apticron nano nmap uuid bind9-host ntp ntpdate ethstatus sqlite3 libsqlite3-dev hdparm debian-keyring g++-multilib dh-make alien rpm lsof lsscsi sysstat jed bzip2 strace gcc g++ autoconf automake autoconf2.13 autoconf-archive gnu-standards libtool gettext gcc-4.4-locales g++-multilib g++-4.4-multilib gcc-multilib make automake1.9 flex bison gdb gcc-4.4-multilib libmudflap0-4.4-dev libcloog-ppl0 libppl-c2 libppl7 binfmt-support elfutils snmp snmpd apt-file nagios-nrpe-server tcl tk debian-keyring debian-archive-keyring strace traceroute telnet bc sysvinit-utils psmisc libncurses5-dev libmysqlclient-dev mtr git
	apt-get dist-upgrade
	apt-file update
	dpkg-reconfigure apticron
all:
	cat profile >> /etc/profile
	cp -a bashrc /root/.bashrc
	. /root/.bashrc
	cp -a vim/* /etc/vim/
