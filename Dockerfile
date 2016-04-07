FROM  cloudbees/pse-master

USER root

RUN apt-get update && apt-get install -y collectd
RUN apt-get install monit -y
RUN apt-get install gettext -y

# collectd configuration
COPY collectd.conf /tmp/collectd.conf

# monit configuration
COPY monitrc /etc/monit/monitrc
RUN chown root:root /etc/monit/monitrc
RUN chmod 700 /etc/monit/monitrc

COPY monit.collectd /etc/monit/conf.d/collectd
RUN chown root:root /etc/monit/conf.d/collectd
RUN chmod 700 /etc/monit/conf.d/collectd

# jmx configuration
COPY jmxremote.* /usr/lib/jvm/
RUN chmod 600 /usr/lib/jvm/jmxremote.*
RUN chown jenkins /usr/lib/jvm/jmxremote.*

# Add the run script
COPY start_container.sh /tmp/run.sh

ENTRYPOINT ["/bin/tini", "--", "/tmp/run.sh"]
