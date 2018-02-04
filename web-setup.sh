#!/bin/bash
# Author: Romildo Wildgrube

## Change default root directory for html pages
#sed -i "/^\troot */c\\\troot /vagrant/www/html;" /etc/nginx/sites-enabled/default

cat > /usr/share/nginx/html/index.html <<EOD
<html><head><title>${HOSTNAME}</title></head><body><h1>${HOSTNAME}</h1>
<p>This is the default web page for ${HOSTNAME}.</p>
</body></html>
EOD
/usr/sbin/service nginx stop
/usr/sbin/service nginx start
