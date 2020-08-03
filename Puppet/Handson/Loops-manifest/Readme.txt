Using Loops in Manifest

on Master:
============================
node default{

$packages = ['apache2','mysql-server']

package {$packages:
ensure => installed,
}

$text = "Intellipaat devops course"


file { '/tmp/statuses.txt':
content => $text ,
mode => '0644',
}
}



on Slave:
============================

root@ip-172-31-13-122:~# sudo puppet agent --test
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for ip-172-31-13-122.ap-south-1.compute.internal
Info: Applying configuration version '1596367991'
Notice: /Stage[main]/Main/Node[default]/Package[apache2]/ensure: created
Notice: /Stage[main]/Main/Node[default]/Package[mysql-server]/ensure: created
Notice: /Stage[main]/Main/Node[default]/File[/tmp/statuses.txt]/ensure: defined content as '{md5}c4b599a9c861ad9b56feff5268eca53a'
Notice: Applied catalog in 35.38 seconds
root@ip-172-31-13-122:~# service mysql status
● mysql.service - MySQL Community Server
   Loaded: loaded (/lib/systemd/system/mysql.service; enabled; vendor preset: en
   Active: active (running) since Sun 2020-08-02 11:33:43 UTC; 15s ago
 Main PID: 6772 (mysqld)
    Tasks: 27 (limit: 1121)
   CGroup: /system.slice/mysql.service
           └─6772 /usr/sbin/mysqld --daemonize --pid-file=/run/mysqld/mysqld.pid

Aug 02 11:33:42 ip-172-31-13-122 systemd[1]: Starting MySQL Community Server...
Aug 02 11:33:43 ip-172-31-13-122 systemd[1]: Started MySQL Community Server.
lines 1-10/10 (END)

root@ip-172-31-13-122:~# service apache status
Unit apache.service could not be found.
root@ip-172-31-13-122:~# service apache2 status
● apache2.service - The Apache HTTP Server
   Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset:
  Drop-In: /lib/systemd/system/apache2.service.d
           └─apache2-systemd.conf
   Active: active (running) since Sun 2020-08-02 11:33:17 UTC; 1min 47s ago
 Main PID: 5805 (apache2)
    Tasks: 55 (limit: 1121)
   CGroup: /system.slice/apache2.service
           ├─5805 /usr/sbin/apache2 -k start
           ├─5807 /usr/sbin/apache2 -k start
           └─5808 /usr/sbin/apache2 -k start

Aug 02 11:33:17 ip-172-31-13-122 systemd[1]: Starting The Apache HTTP Server...
Aug 02 11:33:17 ip-172-31-13-122 systemd[1]: Started The Apache HTTP Server.
