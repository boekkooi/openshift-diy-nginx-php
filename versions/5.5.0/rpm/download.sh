#!/bin/bash
PHP_RPM_URI=http://us-east.repo.webtatic.com/yum/el6/x86_64
PHP_RPM=( cli common bcmath dba devel embedded enchant gd imap interbase intl ldap mbstring mcrypt mysql55 opcache pdo pgsql process pspell recode snmp soap tidy xml xmlrpc zts  )
PHP_RPM_PKG=php55w
PHP_RPM_VERSION=5.5.0-1.w6.x86_64

wget --output-document=./php.rpm "${PHP_RPM_URI}/${PHP_RPM_PKG}-${PHP_RPM_VERSION}.rpm"
for pkg in "${PHP_RPM[@]}"
do
    wget --output-document=./php-${pkg}.rpm "${PHP_RPM_URI}/${PHP_RPM_PKG}-${pkg}-${PHP_RPM_VERSION}.rpm"
done

wget --output-document=./php-pear.rpm "${PHP_RPM_URI}/${PHP_RPM_PKG}-pear-1.9.4-6.w6.noarch.rpm"
wget --output-document=./php-memcache.rpm "${PHP_RPM_URI}/${PHP_RPM_PKG}-pecl-memcache-3.0.8-1.w6.x86_64.rpm"