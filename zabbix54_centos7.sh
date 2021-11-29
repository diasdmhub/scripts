### ZABBIX INSTALATION FROM SOURCES FOR CENTOS 7
### https://www.zabbix.com/documentation/current/manual/installation/install
### ASSUME A NEW INSTALATION
#!/bin/bash


### 001.000 OS ENVIROMENT - START
yum install -y epel-release yum-utils nano wget
yum clean all
yum -y upgrade
### 001.000 OS ENVIROMENT - END


### 002.000 ZABBIX DOWNLOAD - START
wget https://cdn.zabbix.com/zabbix/sources/stable/5.4/zabbix-5.4.7.tar.gz
tar -zxvf zabbix-5.4.7.tar.gz
### 002.000 ZABBIX DOWNLOAD - END


### 003.000 GO INSTALL - START
### https://go.dev/doc/install
wget https://go.dev/dl/go1.17.3.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.3.linux-amd64.tar.gz
nano /etc/profile
	export PATH=$PATH:/usr/local/go/bin
source /etc/profile
### 003.000 GO INSTALL - END


### 004.000 DB - START
### https://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/
### IF YOU ALREADY HAVE A ZABBIX DB, YOU MAY SKIP STEP 004.

### 004.001 MYSQL INSTALL - START
rpm -Uvh https://dev.mysql.com/get/mysql80-community-release-el7-4.noarch.rpm
yum install -y mysql-community-server
systemctl start mysqld
### 004.001 MYSQL INSTALL - END

### 004.002 AJUST ROOT PASS AND CREATE ZABBIX DB - START
MYSQLTEMPPASS=`grep 'temporary password' /var/log/mysqld.log | awk '{print $13}'`
mysql -uroot -p$MYSQLTEMPPASS
	ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
	SET GLOBAL validate_password.policy=LOW;  # ignore if you want a strong password
	SET GLOBAL validate_password.length=6;  # ignore if you want a strong password
	ALTER USER 'root'@'localhost' IDENTIFIED BY '[º°CHANGE TO YOUR PASS°º]';  # change root password to your liking

	create database zabbix character set utf8 collate utf8_bin;
	create user zabbix@localhost identified by 'zabbix';
	grant all privileges on zabbix.* to zabbix@localhost;
	ALTER USER 'zabbix'@'localhost' IDENTIFIED WITH mysql_native_password BY 'zabbix';  # password is "zabbix". Change if you'd like
	quit;
mysql_secure_installation
### 004.002 AJUSTED ROOT PASS AND CREATED ZABBIX DB - END


### 004.003 ZABBIX DB SCHEMA - START
mysql -uzabbix -pzabbix zabbix < database/mysql/schema.sql
mysql -uzabbix -pzabbix zabbix < database/mysql/images.sql
mysql -uzabbix -pzabbix zabbix < database/mysql/data.sql
### 004.003 ZABBIX DB SCHEMA - END

### 004.000 DB MYSQL INSTALL - END


### 005.000 PHP DEP- ENDENCIES AND APACHE2 INSTALATION - START
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --enable remi-php74
yum install -y php php-opcache php-mcrypt php-gd php-curl php-mysqlnd php-bcmath php-mbstring php-xml php-ldap
### 005.000 PHP DEP- ENDENCIES - END


### 006.000 ZABBIX SOURCES DEP- ENDENCIES - START
yum install -y gcc gcc-c++ mysql-devel libxml2 libxml2-devel net-snmp net-snmp-utils net-snmp-devel libcurl libcurl-devel libssh2-devel openldap-devel libevent libevent-devel
### 006.000 ZABBIX SOURCES DEP- ENDENCIES - END


### 007.000 ZABBIX USER - START
groupadd --system zabbix
useradd --system -g zabbix -d /usr/lib/zabbix -s /sbin/nologin -c "Zabbix Monitoring System" zabbix
### 007.000 ZABBIX USER - END


### 008.000 ZABBIX SOURCES INSTALL - START
./configure --enable-server --enable-agent --enable-agent2 --enable-webservice --with-mysql --enable-ipv6 --with-net-snmp --with-libcurl --with-libxml2 --with-openssl --with-ldap --with-ssh2
make install
### 008.000 ZABBIX SOURCES INSTALL - END


### 009.000 ZABBIX FRONT- END INSTALL - START
mkdir /var/www/html/zabbix/
cp -a zabbix-5.4.7/ui/* /var/www/html/zabbix/
chown -R zabbix:zabbix /var/www/html/zabbix/
setsebool -P httpd_can_connect_zabbix on
setsebool -P httpd_can_network_connect_db on
nano /etc/selinux/config
	SELINUX=disabled
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --add-port={10051/tcp,10050/tcp} --permanent

sed -i 's|post_max_size = 8M|post_max_size = 16M|' /etc/php.ini
sed -i 's|max_execution_time = 30|max_execution_time = 300|' /etc/php.ini
sed -i 's|max_input_time = 60|max_input_time = 300|' /etc/php.ini

systemctl enable httpd
systemctl restart httpd
reboot
### 009.000 ZABBIX FRONT- END INSTALL - END


### ZABBIX SERVER SERVICE CONFIGURATION FOR SYSTEMD - START
nano /usr/lib/systemd/system/zabbix-server.service
	[Unit]
	Description=Zabbix Server from Sources
	Documentation=man:zabbix_server
	After=network.target
	After=mysqld.service

	[Service]
	Environment="CONFFILE=/usr/local/etc/zabbix_server.conf"
	Type=simple
	PIDFile=/tmp/zabbix_server.pid
	KillMode=control-group
	ExecStart=/usr/local/sbin/zabbix_server -c $CONFFILE
	ExecStop=/bin/sh -c '[ -n "$1" ] && kill -s TERM "$1"' -- "$MAINPID"
	RestartSec=10s
	Restart=on-failure
	TimeoutSec=infinity

	[Install]
	WantedBy=multi-user.target
### ZABBIX SERVER SERVICE CONFIGURATION FOR SYSTEMD - END


### ZABBIX AGENT SERVICE CONFIGURATION FOR SYSTEMD - START
nano /usr/lib/systemd/system/zabbix-agent.service
	[Unit]
	Description=Zabbix Agent from Sources
	After=rsyslog.target
	After=network.target

	[Service]
	Environment="CONFFILE=/usr/local/etc/zabbix_agentd.conf"
	Type=simple
	Restart=on-failure
	PIDFile=/tmp/zabbix_agentd.pid
	KillMode=control-group
	ExecStart=/usr/local/sbin/zabbix_agentd -c $CONFFILE
	ExecStop=/bin/sh -c '[ -n "$1" ] && kill -s TERM "$1"' -- "$MAINPID"
	RestartSec=10s
	User=zabbix
	Group=zabbix

	[Install]
	WantedBy=multi-user.target
### ZABBIX AGENT SERVICE CONFIGURATION FOR SYSTEMD - END


### ZABBIX CONFIGURATION - START
systemctl daemon-reload
nano /usr/local/etc/zabbix_server.conf
nano /usr/local/etc/zabbix_agentd.conf
systemctl enable zabbix-server zabbix-agent
systemctl start zabbix-server zabbix-agent
### ZABBIX CONFIGURATION - END


### DOWNLOAD FRONTEND CONFIG IF IT FAILS THEN COPY IT TO YOUR SERVER - START
mv ~/zabbix.conf.php /var/www/html/zabbix/conf/zabbix.conf.php
systemctl restart httpd
### DOWNLOAD FRONTEND CONFIG IF IT FAILS THEN COPY IT TO YOUR SERVER - END
