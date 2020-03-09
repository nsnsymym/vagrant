yum update
yum -y install wget zip unzip

setenforce 0
sed -i -e "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

systemctl restart firewalld
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

yum -y install epel-release
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum -y install --enablerepo=remi,remi-php73 php php-fpm php-pdo php-mbstring php-gd php-json php-mysql php-xml php-pecl-zip php-intl php-composer composer

cp /etc/php.ini /etc/php.ini.org
sed -i -e "s/;date\.timezone =/date\.timezone = Asia\/Tokyo/g" /etc/php.ini
sed -i -e "s/display_errors = Off/display_errors = On/g" /etc/php.ini

# composer install
# yum install -y composer
# EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
# php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"
# if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
# then
#     >&2 echo 'ERROR: Invalid installer signature'
#     rm composer-setup.php
#     exit 1
# fi
# php composer-setup.php --quiet
# RESULT=$?
# rm composer-setup.php

# mv composer.phar /usr/local/bin/composer

systemctl start httpd
systemctl enable httpd

cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.org
sed -i -e "s/AllowOverride None/AllowOverride All/g" /etc/httpd/conf/httpd.conf
sed -i -e "s/DirectoryIndex index.html/DirectoryIndex index.php index.html/g" /etc/httpd/conf/httpd.conf

systemctl reload httpd

yum -y localinstall http://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
yum install -y yum-utils
yum-config-manager --disable mysql80-community
yum-config-manager --enable mysql57-community
yum -y install mysql-community-server mysql-community-devel mysql-utilities

# sed -i -e "s/# default-authentication-plugin=mysql_native_password/default_authentication_plugin=mysql_native_password\ncharacter-set-server = utf8/g" /etc/my.cnf

systemctl enable mysqld
systemctl restart mysqld

database=test_db
user=db_user
host_name=localhost
password=`cat /var/log/mysqld.log | grep "A temporary password" | tr ' ' '\n' | tail -n1`
new_password=passwordPASSWORD@999

mysql -u root -p${password} --connect-expired-password -e "alter user root@localhost identified by '${new_password}'"
mysql -u root -p${new_password} --connect-expired-password -e "create database $database"
mysql -u root -p${new_password} --connect-expired-password -e "create user $user@$host_name identified by '$new_password'"
mysql -u root -p${new_password} --connect-expired-password -e "grant all privileges on $database.* to $user@$host_name with grant option"
mysql -u root -p${new_password} --connect-expired-password < /vagrant/db/database.sql

