You work for Tech Giants Software. Recently the company got funding and they have decided
to expand their server fleet. You have been designated the task for Configuration Management.
Assume the following infrastructure:
1. 1 Nginx Server
2. 1 Apache Server
3. 1 Puppet Master
On Apache Server, we have to install docker. And on the nginx server, we have to install Java.
It sounds straightforward, but we do not know, which systems have what software installed on
it.
Using conditional statements, accomplish the above task.
Also, for improving code readability, please make use of modules and classes.


nginx server:
create direcory under 
root@ip-172-31-7-174:/etc/puppet/code/environments/production/modules#
mkdir -p nginx/manifests

vi init.pp

x/manifests# cat init.pp
class nginx
{
        # execute 'apt-get update'
        exec { 'apt-update':
                command => '/usr/bin/apt-get update'
        }

        # execute 'apt-get install -y openjdk-8-jdk'
        exec { 'apt-get':
                command => '/usr/bin/apt-get -y install openjdk-8-jdk',
        }

        exec { "conditions":
        command => "/bin/echo java is installed > /tmp/status_java.txt",
        onlyif => "/bin/which java",
        }

}


create direcory under 
root@ip-172-31-7-174:/etc/puppet/code/environments/production/modules#
mkdir -p apache/manifests

he/manifests# cat init.pp
class apache
{
 package{ 'curl':
        ensure => present,

}

exec { 'apt-update':
command => '/usr/bin/apt-get update',
}

exec { 'download_docker_key':
command => '/usr/bin/curl -fsSL http://download.docker.com/linux/ubuntu/gpg | sudo apt-key add' ,
}
exec { 'add_docker_repo':
command => '/usr/bin/add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"',
require => Exec['apt-update']
}
exec {'docker_cache':
command => '/usr/bin/apt-cache policy docker-ce',
}
exec {'install_docker':
command => '/usr/bin/apt-get install -y docker-ce',
}
}
root@ip-172-31-7-174:/etc/puppet/code/environments/production/modules/apache/manifests#



root@ip-172-31-7-174:/etc/puppet/code/environments/production/manifests# ls
1  site.pp
root@ip-172-31-7-174:/etc/puppet/code/environments/production/manifests# cat site.pp
node 'ip-172-31-13-122.ap-south-1.compute.internal'{
include nginx
}

root@ip-172-31-7-174:/etc/puppet/code/environments/production/manifests# cat site.pp
node 'ip-172-31-13-122.ap-south-1.compute.internal'{
include apache
}

On slave
=========

root@ip-172-31-13-122:/tmp# puppet agent --test
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Loading facts
Info: Caching catalog for ip-172-31-13-122.ap-south-1.compute.internal
Info: Applying configuration version '1596453315'
Notice: /Stage[main]/Apache/Exec[apt-update]/returns: executed successfully
Notice: /Stage[main]/Apache/Exec[download_docker_key]/returns: executed successfully
Notice: /Stage[main]/Apache/Exec[add_docker_repo]/returns: executed successfully
Notice: /Stage[main]/Apache/Exec[docker_cache]/returns: executed successfully
Notice: /Stage[main]/Apache/Exec[install_docker]/returns: executed successfully
Notice: Applied catalog in 31.72 seconds
root@ip-172-31-13-122:/tmp# docker -v
Docker version 19.03.12, build 48a66213fe

=================================

root@ip-172-31-13-122:~# puppet agent --test
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Loading facts
Info: Caching catalog for ip-172-31-13-122.ap-south-1.compute.internal
Info: Applying configuration version '1596452141'
Notice: /Stage[main]/Nginx/Exec[apt-update]/returns: executed successfully
Notice: /Stage[main]/Nginx/Exec[apt-get]/returns: executed successfully
Notice: /Stage[main]/Nginx/Exec[conditions]/returns: executed successfully
Notice: Applied catalog in 3.44 seconds
root@ip-172-31-13-122:~# cd /tmp
root@ip-172-31-13-122:/tmp# ls
hello.txt
hsperfdata_root
module_test.txt
mysoft.txt
software.txt
status_apache.txt
status_java.txt
systemd-private-1317aa95115f4a9f80cfe8e6da8e0979-systemd-resolved.service-84Iiqf
systemd-private-1317aa95115f4a9f80cfe8e6da8e0979-systemd-timesyncd.service-9o9DxS
tmp.9Y8KrS72dB
root@ip-172-31-13-122:/tmp# cat status_java.txt
java is installed

