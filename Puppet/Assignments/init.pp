exec { 'apt-update':
command => '/usr/bin/apt-get update',
}

package { 'apache2':
require => Exec['apt-update'],
ensure => installed,
}

service { 'apache2':
ensure => running,
}

file { '/var/www/html/index.html':
content => "<html>
<body>
<h1> Welcome to Intellipaat</h1>
</body>
</html> \n",
mode => '0644',

}
}

