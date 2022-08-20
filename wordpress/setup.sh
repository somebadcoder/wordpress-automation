#!/bin/sh
# Cloudflare APO Environment
# A work in progress

echo "Please enter a hostname (no http://) below " 
read -p "" URL
echo "You typed: $URL"
echo ""
read -s -p "Please enter a strong database password: " DATABASE_PASSWORD
echo ""
echo "DB Password: $DATABASE_PASSWORD"
echo ""
#read -s -p "Please set a password for your WP Admin " WP_PASSWORD
#echo ""
#echo "WP user password: $WP_PASSWORD"
#echo ""
echo "I will take 5 - 10 minutes"


sudo apt update -y ; 
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update -y
sudo apt install apache2 mysql-server unzip software-properties-common ca-certificates lsb-release apt-transport-https -y; 
sudo apt-get install php7.4 php7.4-common libapache2-mod-php7.4 php7.4-cli php7.4-gd php7.4-mysql php7.4-curl php7.4-dom php7.4-imagick php7.4-mbstring php7.4-zip php7.4-int   -y


git clone https://github.com/somebadcoder/wordpress-automation.git
mv wordpress-automation/wordpress/wordpress.sql .
mv wordpress-automation/wordpress/ /var/www/html/
rm -rf wordpress-automation
sudo echo "<?php phpinfo(); ?>" > /var/www/html/wordpress/phpinfo.php ;
sed -i "s/updatepass/$DATABASE_PASSWORD/g" /var/www/html/wordpress/wp-config.php
chown www-data:www-data -R /var/www/html/wordpress


cat << EOF > /etc/apache2/sites-available/wordpress.conf
<VirtualHost *:80>
    # The primary domain for this host
    ServerName $URL
    # Optionally have other subdomains also managed by this Virtual Host
    # ServerAlias www.$URL
    DocumentRoot /var/www/html/wordpress
    <Directory /var/www/html/wordpress>
        Require all granted
        # Allow local .htaccess to override Apache configuration settings
        AllowOverride all
    </Directory>
    # Enable RewriteEngine
    RewriteEngine on
    RewriteOptions inherit

    # Block .svn, .git
    RewriteRule \.(svn|git)(/)?$ - [F]


    # Recommended: XSS protection
    <IfModule mod_headers.c>
        Header set X-XSS-Protection "1; mode=block"
        Header always append X-Frame-Options SAMEORIGIN
    </IfModule>
</VirtualHost>
EOF

sudo a2ensite wordpress.conf
sudo a2enmod rewrite && systemctl restart apache2;
sudo ufw allow in "Apache Full" ;
ufw allow 22;


SQL_COMMAND_1="CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
SQL_COMMAND_2="CREATE USER 'wordpress'@'localhost' IDENTIFIED BY '${DATABASE_PASSWORD}';"
SQL_COMMAND_3="GRANT ALL ON wordpress.* TO 'wordpress'@'localhost';"
SQL_COMMAND_3="FLUSH PRIVILEGES;"

mysql -u root << eof
$SQL_COMMAND_1
eof
mysql -u root << eof
$SQL_COMMAND_2
eof
mysql -u root << eof
$SQL_COMMAND_3
eof
mysql -u root << eof
$SQL_COMMAND_4
eof

mysql -u root wordpress < wordpress.sql

systemctl restart apache2


echo "You can use PHPMyAdmin at: $URL/php"
echo "DB Name: wordpress"
echo "Database Password: $DATABASE_PASSWORD"
echo "WP Username: adm_adm"
echo "Reset your password in PHPMyAdmin and update home/site URLs"
echo "You can login at: $URL/wp-admin"


# SQL_COMMAND_6="UPDATE `wp_options` SET `option_value` = 'http://${URL}' WHERE `wp_options`.`option_id` = 1;"
# SQL_COMMAND_7="UPDATE `wp_options` SET `option_value` = 'http://${URL}' WHERE `wp_options`.`option_id` = 2;"
# SQL_COMMAND_8="UPDATE `wp_options` SET `option_value` = 'invalid@${URL}' WHERE `wp_options`.`option_id` = 6;"
# SQL_COMMAND_9="UPDATE `wp_users` SET `user_pass` = MD5('${WP_PASSWORD}'), `user_email` = 'invalid@${URL}', `user_url` = 'http://${URL}' WHERE `wp_users`.`ID` = 1;"
# SQL_COMMAND_10="FLUSH PRIVILEGES;"
# SELECT * FROM `wp_options` WHERE 1
# UPDATE `wp_options` SET `option_value` = 'http://${URL' WHERE `wp_options`.`option_id` = 1
# UPDATE `wp_options` SET `option_value` = 'http://${URL' WHERE `wp_options`.`option_id` = 2;
# SELECT * FROM `wp_users`
# UPDATE `wp_users` SET `user_url` = 'http://${URL' WHERE `wp_users`.`ID` = 1
# UPDATE `wp_users` SET `user_pass` = MD5('${WP_PASSWORD}') WHERE `wp_users`.`ID` = 1;

