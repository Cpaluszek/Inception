#!/bin/sh

# Automate the installation and configuration of wordpress on the server

# Change directory to where the wordpress file will be downloaded
cd /var/www/html/wordpress

# Download wordpress files
wp core download  --path="/var/www/html/wordpress" --allow-root

# Generate and configure wp-config.php - Including database connection info
wp config create --path="/var/www/html/wordpress" --allow-root --dbname=$DB_DATABASE --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=$DB_HOST --dbprefix=wp_

# Install wordpress - configure URL / Title / Admin info
# Also creates wordpress tables in the database
wp core install --path="/var/www/html/wordpress" --allow-root --url=$DOMAIN_NAME --title="$WP_SITE_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL

wp plugin update --allow-root --all

# Create a new user

wp user create --path="/var/www/html/wordpress" --allow-root $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD

# Permissions to WWW-DATA for the upload directory | -R EXECUTE ROOT
chown www-data:www-data /var/www/html/wordpress/wp-content/uploads -R

# LAUNCH PHP-FPM
mkdir -p /run/php/
php-fpm7.3 -F 
