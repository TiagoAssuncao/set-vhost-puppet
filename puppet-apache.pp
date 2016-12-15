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


apache::vhost { 'app1.4linux.com.br':
  port    => '80',
  docroot => "/var/www/app1.4linux.com.br/public_html",
  docroot_owner => 'www-data',
  docroot_group => 'www-data',
  options       => ['Indexes','FollowSymLinks','MultiViews'],
  override      => ['none'],
  proxy_pass => [
    {
      'path' => '/app1',
      'url'  => 'http://localhost:80/app1'
    },
  ],
}

apache::vhost { 'app2.4linux.com.br':
  port    => '81',
  docroot => '/var/www/app1.4linux.com.br/public_html',
  docroot_owner => 'www-data',
  docroot_group => 'www-data',
  options       => ['Indexes','FollowSymLinks','MultiViews'],
  override      => ['none'],
  proxy_pass => [
    {
      'path' => '/app2',
      'url'  => 'http://localhost:81/app2'
    },
  ],
}

apache::vhost { 'app3.4linux.com.br':
  port    => '82',
  docroot => '/var/www/app1.4linux.com.br/public_html',
  docroot_owner => 'www-data',
  docroot_group => 'www-data',
  options       => ['Indexes','FollowSymLinks','MultiViews'],
  override      => ['none'],
  proxy_pass => [
    {
      'path' => '/app3',
      'url'  => 'http://localhost:82/app3'
    },
  ],
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

