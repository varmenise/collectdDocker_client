export JAVA_OPTS="-Dcom.sun.management.jmxremote.port=12345 -Dcom.sun.management.jmxremote.ssl=false \
                  -Dcom.sun.management.jmxremote.password.file=/usr/lib/jvm/jmxremote.password \
                  -Dcom.sun.management.jmxremote.access.file=/usr/lib/jvm/jmxremote.access $JAVA_OPTS"

                  
exec /usr/local/bin/launch-jenkins-master.sh