FROM  cloudbees/pse-master

USER root

RUN apt-get update && apt-get install -y collectd
RUN apt-get install gettext -y
RUN apt-get install supervisor -y

# supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# collectd configuration
COPY collectd.conf /tmp/collectd.conf

# jmx configuration
COPY jmxremote.* /usr/lib/jvm/
RUN chmod 600 /usr/lib/jvm/jmxremote.*
RUN chown jenkins:jenkins /usr/lib/jvm/jmxremote.*

# Add the run script
COPY start_container.sh /usr/local/bin/run.sh

#ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/run.sh"]
ENTRYPOINT ["/usr/bin/supervisord"]
