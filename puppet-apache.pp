class { '::apache': }

define create_index($index){
  # create a directory      
  file {[
    "/var/www/app${index}.4linux.com.br",
    "/var/www/app${index}.4linux.com.br/public_html"]:
      ensure => 'directory',
      recurse => true,
  }

  file { "/var/www/app${index}.4linux.com.br/public_html/index.html":
    ensure  => 'present',
    replace => 'yes',
    content => "<h1>INSTANCIA${index}</h1>",
    mode    => '0644',
  }
}

create_index{
  "app1" : index => 1;
  "app2" : index => 2;
  "app3" : index => 3;
}

class apache2 {
  package {'apache2':
    ensure => present,
  }
  service {'apache2':
    ensure => "running",
    enable => "true",
    require => Package["apache2"],
  }
  file { '/etc/ssh/sshd_config':
    notify  => Service['apache2'],
    owner   => 'root',
    group   => 'root',
    require => Package['apache2'],
  }
  apache::vhost { 'app1.4linux.com.br':
    port    => '80',
    docroot => "/var/www/app1.4linux.com.br/public_html",
  }

  apache::vhost { 'app2.4linux.com.br':
    port    => '81',
    docroot => '/var/www/app1.4linux.com.br/public_html',
  }

  apache::vhost { 'app3.4linux.com.br':
    port    => '82',
    docroot => '/var/www/app1.4linux.com.br/public_html',
  }

  exec { "reload":
    command => "/etc/init.d/apache2 reload",
    refreshonly => true,
    require => Service[[apache2]],
  }

  exec { "restart":
    command => "/etc/init.d/apache2 restart",
    refreshonly => true,
    require => Service[[apache2]],
  }
}

include apache2
