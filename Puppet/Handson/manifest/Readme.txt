root@ip-172-31-7-174:/etc/puppet/code/environments/production/manifests# ls -lrt
total 4
-rw-r--r-- 1 root root 134 Aug  2 11:16 site.pp


Creating a Manifest 

node default{

package {'nginx':
ensure => installed,
}

file { '/tmp/status.txt':
content => 'Nginx installed',
mode => '0644',
}
}


-- from the slave machine

 puppet agent --test
