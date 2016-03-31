FROM java:8-jdk

USER root

RUN apt-get update && apt-get install -y collectd
RUN apt-get install monit -y
RUN apt-get install gettext -y

# collectd configuration
ADD collectd.conf /tmp/collectd.conf

# monit configuration
ADD monitrc /etc/monit/monitrc
RUN chown root:root /etc/monit/monitrc
RUN chmod 700 /etc/monit/monitrc

ADD monit.collectd /etc/monit/conf.d/collectd
RUN chown root:root /etc/monit/conf.d/collectd
RUN chmod 700 /etc/monit/conf.d/collectd

# jmx configuration
ADD jmxremote.access /usr/lib/jvm/jmxremote.access
ADD jmxremote.password /usr/lib/jvm/jmxremote.password
chmod 600 usr/lib/jvm/jmxremote.access
chmod 600 usr/lib/jvm/jmxremote.password

# Add the run script
ADD start_container.sh /tmp/run.sh

EXPOSE 25826

ENTRYPOINT ["/bin/bash","/tmp/run.sh"]