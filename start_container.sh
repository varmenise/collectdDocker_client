envsubst < /tmp/collectd.conf > /etc/collectd/collectd.conf
service collectd restart
/usr/bin/monit -I 