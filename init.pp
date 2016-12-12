class development ($userName){
	$devpackages = ["mysql-server", "mysql-client", "netbeans", "mysql-workbench", "git", "gedit", "ssh"]

	package{"apache2":
		ensure=> "installed",
	}

	package{$devpackages: 
		ensure => "installed",
	}

	file{"/home/$userName/workspace":
		ensure => "directory",
	}

	file{"/home/$userName/public_html":
		ensure => "directory",
	}

	file{"/etc/apache2/mods-enabled/userdir.conf":
		ensure => "link",
		target => "../mods-available/userdir.conf",
		require => Package["apache2"],
		notify => Service["apache2"],
	}

	file{"/etc/apache2/mods-enabled/userdir.load": 
                ensure => "link",
                target => "../mods-available/userdir.load",
                require => Package["apache2"],
                notify => Service["apache2"],
        }

	file{"/var/www/html/index.html":
		ensure => "present",
		content => template("development/index.html"),
		require => Package["apache2"],
		notify => Service["apache2"],
	}

	file{"/home/$userName/public_html/index.html":
		ensure => "present",
		content => template("development/index.html"),
	}

	service{"apache2":
		ensure => "running",
		enable => "true",
		provider => "systemd",
	}

	service{"ssh":
		ensure => "running",
		enable => "true",
		provider => "systemd",
	}
}
