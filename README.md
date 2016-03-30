# collectd-client-docker
A docker image for collectd client.
The available plugins to collect metrics are listed [here](https://collectd.org/wiki/index.php/Table_of_Plugins). To enable one, uncomment the corresponding line in the `collectd.conf` file.

## Build the image:

`docker build -t collectd/myversion .`

## Run the container:

`docker run -d -p 25826:25826/udp collectd/myversion`

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
