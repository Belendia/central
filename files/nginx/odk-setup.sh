echo "writing a new nginx configuration file.."
/bin/bash -c "cp /usr/share/nginx/odk.conf.template /etc/nginx/conf.d/odk.conf"
nginx -g "daemon off;"


