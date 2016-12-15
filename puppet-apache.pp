class { '::apache': }

define create_file($index){
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

define set_vhosts($port, $index){
  apache::vhost { 'app1.4linux.com.br':
    port    => $port,
    docroot => "/var/www/app${index}.4linux.com.br/public_html",
    docroot_owner => 'www-data',
    docroot_group => 'www-data',
    options       => ['Indexes','FollowSymLinks','MultiViews'],
    override      => ['none'],
  }
}

create_file{
  "app1" : index => 1;
  "app2" : index => 2;
  "app3" : index => 3;
}

set_vhosts{
  "app1" : port => 80, index => 1;
  "app2" : port => 81, index => 2;
  "app3" : port => 82, index => 3;
}

exec { "reload":
  command => "/etc/init.d/apache2 reload",
  user => "root",
}
