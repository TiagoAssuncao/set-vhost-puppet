class { '::apache': }

# Most basic vhost
apache::vhost { 'app1.4linux.com.br':
  port    => '80',
  docroot => '/var/www/exemplo.networkabout.com/public_html',
}

apache::vhost { 'app2.4linux.com.br':
  port    => '81',
  docroot => '/var/www/teste.networkabout.com/public_html',
}

apache::vhost { 'app3.4linux.com.br':
  port    => '82',
  docroot => '/var/www/teste.networkabout.com/public_html',
}
