class profile::wordpress (
	$dbname = 'wordpress-db',
	$dbuser = 'wordpress',
	$dbpassword = 'wordpress',
	$dbhost = 'localhost',
) {
	exec { 'download wordpress':
		command => '/bin/wget https://wordpress.org/latest.tar.gz -O /opt/latest.tar.gz',
		creates => '/opt/latest.tar.gz',
	}~>
	exec { 'extract gzip':
		command => '/bin/tar -C /var/www/html -xvzf /opt/latest.tar.gz',
		refreshonly => 'true',
	}~>
	file { '/var/www/html/wordpress/wp-config.php' :
		ensure => 'file',
		content => template('profile/wp-config.php.erb'),
	}
	mysql::db { $dbname:
		user => $dbuser,
		password => $dbpassword,
		host => $dbhost,
		grant => ['ALL'],
	}
	exec { 'restart apache':
		command => 'systemctl restart httpd',
		path => '/usr/bin',
	}
}
