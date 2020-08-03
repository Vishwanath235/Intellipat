=============================
USING VARIABLES IN MANIFESTS 
=============================
On master

node default{

$text="hello world"
file{'/tmp/hello.txt':
content => $text,
mode => '0644',

}

}


on slave
===========

root@ip-172-31-13-122:~# sudo puppet agent --test
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for ip-172-31-13-122.ap-south-1.compute.internal
Info: Applying configuration version '1596376007'
Notice: /Stage[main]/Main/Node[default]/File[/tmp/hello.txt]/ensure: defined content as '{md5}5eb63bbbe01eeed093cb22bb8f5acdc3'
Notice: Applied catalog in 0.02 seconds
root@ip-172-31-13-122:~# cd /tmp
root@ip-172-31-13-122:/tmp# ls
hello.txt
status_apache.txt
systemd-private-1317aa95115f4a9f80cfe8e6da8e0979-systemd-resolved.service-84Iiqf
systemd-private-1317aa95115f4a9f80cfe8e6da8e0979-systemd-timesyncd.service-9o9DxS
tmp.9Y8KrS72dB
root@ip-172-31-13-122:/tmp# cat hello.txt
