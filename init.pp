class development ($userName){
	
	Package{ensure => "installed",}
	$devpackages = ["mysql-server", "mysql-client", "netbeans", "mysql-workbench", "git", "gedit", "ssh"]
	
	package{$devpackages:
		ensure => "installed",
	}

	file{"/home/$userName/workspace":
		ensure => "directory",
	}
}
