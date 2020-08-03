
Puppet Installation Steps:

===============================
on Master
===============================

sudo apt-get update
sudo apt-get install wget
wget https://apt.puppetlabs.com/puppet-release-bionic.deb
sudo dpkg -i puppet-release-bionic.deb
sudo apt-get update
sudo apt-get install puppet-master 
apt policy puppet master
systemctl status puppet-master

================================================
vi /etc/default/puppet-master
# Defaults for puppetmaster - sourced by /etc/init.d/puppet-master
JAVA_ARGS="-Xms512m Xmx512m"
# Start puppetmaster on boot?
START=yes

# Startup options.
DAEMON_OPTS=""

================================================
vi /etc/hosts

127.0.0.1 localhost
15.207.109.122 puppet   //master public ip address.
# The following lines are desirable for IPv6 capable hosts
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts

=================================================
root@ip-172-31-7-174:~# sudo ufw allow 8140/tcp
Rules updated
Rules updated (v6)

================================================
root@ip-172-31-7-174:~# puppet cert list
  "ip-172-31-13-122.ap-south-1.compute.internal" (SHA256) A7:46:61:5D:23:E0:E9:2B:90:07:E1:29:18:CD:C1::65:AB:8F:2D:D0:91:E9:4F:62:AB:7E:74:B1:CA:46:4D

$ sudo puppet cert sign --all 


$ sudo nano /etc/hosts
$ sudo mkdir -p /etc/puppet/code/environments/production/manifests 
root@ip-172-31-40-219:/etc/puppet/code/environments/production/manifests# cat site.pp
file {'/tmp/it_works.txt':
  ensure => present,
  mode  => '0644',
  content => "It works on ${ipaddress_eth0}!\n",
}

==================Restart the puppet master services =================

sudo systemctl restart puppet-master

===============================
On Slave:
===============================
sudo apt-get update
sudo apt-get install wget
wget https://apt.puppetlabs.com/puppet-release-bionic.deb
sudo dpkg -i puppet-release-bionic.deb
sudo apt-get update
sudo apt-get install puppet 
apt policy puppet master



Step 3: Make changes to the hosts file which exists in /etc/hosts. And add the Puppet
Master IP address along with the name “puppet”


Configuring Puppet Slave
Step 1: Add the entry for Puppet Master in /etc/hosts

vi /etc/hosts

127.0.0.1 localhost
15.207.109.122 puppet   //master public ip address.
# The following lines are desirable for IPv6 capable hosts
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts

Step 2: Finally start the Puppet agent by using the following command. Also, enable the
service, so that it starts when the computer starts

$ sudo systemctl start puppet
$ sudo systemctl enable puppet 

=======================verify the puppet master-slave configuration ===============================
root@ip-172-31-13-122:/tmp# sudo puppet agent --test
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for ip-172-31-13-122.ap-south-1.compute.internal
Info: Applying configuration version '1596350786'
Notice: /Stage[main]/Main/File[/tmp/it_works.txt]/ensure: defined content as '{md5}4a90c68ae32b7ad274f57c2ec3539bde'
Notice: Applied catalog in 0.02 seconds
root@ip-172-31-13-122:/tmp# ls
it_works.txt
systemd-private-1317aa95115f4a9f80cfe8e6da8e0979-systemd-resolved.service-84Iiqf
systemd-private-1317aa95115f4a9f80cfe8e6da8e0979-systemd-timesyncd.service-9o9DxS
root@ip-172-31-13-122:/tmp# cat it_works.txt
It works on 172.31.13.122!
root@ip-172-31-13-122:/tmp#

