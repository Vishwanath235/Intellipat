classes in puppet

create folder under the directory
root@ip-172-31-7-174:/etc/puppet/code/environments/production/modules#
mkdir -p firstnode/manifests

root@ip-172-31-7-174:/etc/puppet/code/environments/production/modules/firstnode# ls
manifests

create a file called init.pp

root@ip-172-31-7-174:/etc/puppet/code/environments/production/modules/firstnode/manifests# cat init.pp
class firstnode
{
file {'/tmp/mysoft.txt':
content => "this is from firstsoftware",
mode => '0644',
}

}

make the changes in site.pp file under the main manifest folder under the  production directory.

node 'ip-172-31-13-122.ap-south-1.compute.internal'{
include firstnode
}

on Slave
========

root@ip-172-31-13-122:~# puppet agent --test
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Loading facts
Info: Caching catalog for ip-172-31-13-122.ap-south-1.compute.internal
Info: Applying configuration version '1596431938'
Notice: /Stage[main]/Firstnode/File[/tmp/mysoft.txt]/ensure: defined content as '{md5}12b025d0c82b73ed70a035a7645b2389'
Notice: Applied catalog in 0.02 seconds
root@ip-172-31-13-122:~# ls -lrt
total 16
-rw-r--r-- 1 root root 11724 Mar 18 01:58 puppet-release-bionic.deb
drwxr-xr-x 3 root root  4096 Aug  2 06:14 snap
root@ip-172-31-13-122:~# cd /tmp
root@ip-172-31-13-122:/tmp# ls
hello.txt
module_test.txt
mysoft.txt
software.txt
status_apache.txt
systemd-private-1317aa95115f4a9f80cfe8e6da8e0979-systemd-resolved.service-84Iiqf
systemd-private-1317aa95115f4a9f80cfe8e6da8e0979-systemd-timesyncd.service-9o9DxS
tmp.9Y8KrS72dB
root@ip-172-31-13-122:/tmp# cat mysoft.txt
this is from firstsoftwareroot@ip-172-31-13-122:/tmp#
