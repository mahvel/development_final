class development {
	
	Package{ensure => "installed",}
	$devpackages = ["apache2", "mysql-server", "mysql-client", "netbeans", "mysql-workbench", "git", "gedit", "ssh"]

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

	file{"/var/www/html":
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
	}

	service{"ssh":
		ensure => "running",
		enable => "true",
	}
}
