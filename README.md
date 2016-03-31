# collectd-client-docker
A docker image for collectd client.
The available plugins to collect metrics are listed [here](https://collectd.org/wiki/index.php/Table_of_Plugins). To enable one, uncomment the corresponding line in the `collectd.conf` file.

The following metrics are currently retrieved:

* CPU
* df (file system usage information)
* disk (performance statistics of hard-disks)
* interface (traffic of interfaces)
* irq (number of times each interrupt has been handled by the operating system)
* load (system load)
* memory (physical memory utilization)
* swap (memory currently written onto hard disk)
* users (number of users currently logged into the system) 
* java
 * classes (Number of classes loaded by the JVM)
 * compilation (Time spent by the JVM compiling or optimizing)
 * garbage collector (Garbage collector information)
 * memory (Generic heap / nonheap memory usage)
 * memory pool (Memory usage by memory pool)

## Build the image:

`docker build -t collectd/myversion .`

## Run the container:

`docker run -d -p 25826:25826/udp -e "COLLECTD_SERVER=<server_ip_address>" -e "JMX_PORT=<THE_JMX_PORT_OF_YOUR_JMX_AGENT>" collectd/myversion`

# Configure the jxm agent

Start your java process with the following arguments

* `-Dcom.sun.management.jmxremote.port=12345`
* `-Dcom.sun.management.jmxremote.ssl=false`
* `-Dcom.sun.management.jmxremote.password.file=/usr/lib/jvm/jmxremote.password`
* `-Dcom.sun.management.jmxremote.access.file=/usr/lib/jvm/jmxremote.access`

Grant the owner of the process access to the jmxremote authentication files

sudo chown <owner> /usr/lib/jvm/jmxremote.access
sudo chown <owner> /usr/lib/jvm/jmxremote.password

## SSH into the container:

`sudo docker ps` to list the container_id.

Use the <CONTAINER_ID> shown by the command above to ssh running:

`sudo docker exec -i -t <CONTAINER_ID> bash`

### Collectd data location

  * Config file       /etc/collectd/collectd.conf
  * PID file          /var/run/collectd.pid
  * Plugin directory  /usr/lib/collectd
  * Data directory    /var/lib/collectd

 
## TroubleShooting
 
### Check collect is running as root 
`ps aux | grep collectd`

### Check the specified port is open (25826) for UDP traffic
`apt-get install net-tools`

`netstat -a`
