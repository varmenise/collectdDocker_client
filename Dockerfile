FROM java:8-jdk

USER root

RUN apt-get update && apt-get install -y collectd
RUN apt-get install monit -y

# collectd configuration
ADD collectd.conf /etc/collectd/collectd.conf

# monit configuration
ADD monitrc /etc/monit/monitrc
RUN chown root:root /etc/monit/monitrc
RUN chmod 700 /etc/monit/monitrc

ADD monit.collectd /etc/monit/conf.d/collectd
RUN chown root:root /etc/monit/conf.d/collectd
RUN chmod 700 /etc/monit/conf.d/collectd

# Add the run script
ADD start_container.sh /tmp/run.sh

EXPOSE 25826

ENTRYPOINT ["/bin/bash","/tmp/run.sh"]