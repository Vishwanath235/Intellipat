on Master:

node default{

exec { "conditions":
command => "/bin/echo apache2 is installed > /tmp/status_apache.txt",
onlyif => "/bin/which apache2",

}

}


on Slave :
root@ip-172-31-13-122:~# puppet agent --test
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for ip-172-31-13-122.ap-south-1.compute.internal
Info: Applying configuration version '1596368716'
Notice: Applied catalog in 0.02 seconds
root@ip-172-31-13-122:~# cd /tmp/
root@ip-172-31-13-122:/tmp# ls
systemd-private-1317aa95115f4a9f80cfe8e6da8e0979-systemd-resolved.service-84Iiqf
systemd-private-1317aa95115f4a9f80cfe8e6da8e0979-systemd-timesyncd.service-9o9DxS
tmp.9Y8KrS72dB

===========================================================================
on master

node default{

exec { "conditions":
command => "/bin/echo apache2 is not installed > /tmp/status_apache.txt",
unless => "/bin/which apache2",

}

}


on slave
root@ip-172-31-13-122:~# puppet agent --test
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for ip-172-31-13-122.ap-south-1.compute.internal
Info: Applying configuration version '1596375716'
Notice: /Stage[main]/Main/Node[default]/Exec[conditions]/returns: executed successfully
Notice: Applied catalog in 0.03 seconds
root@ip-172-31-13-122:~# cd /tmp
root@ip-172-31-13-122:/tmp# ls
status_apache.txt
systemd-private-1317aa95115f4a9f80cfe8e6da8e0979-systemd-resolved.service-84Iiqf
systemd-private-1317aa95115f4a9f80cfe8e6da8e0979-systemd-timesyncd.service-9o9DxS
tmp.9Y8KrS72dB
root@ip-172-31-13-122:/tmp# cat status_apache.txt
apache2 is not installed
