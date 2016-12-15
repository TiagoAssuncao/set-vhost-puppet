$app1 = 'app1.linux.com.br'
$app2 = 'app2.linux.com.br'
$app3 = 'app3.linux.com.br'

define create_index($domain, $index){
  # create a directory      
  file {["/var/www/${domain}", "/var/www/${domain}/public_html"]:
    replace => 'yes', # this is the important property
    ensure => 'directory',
    recurse => true,
  }

  file { "/var/www/${domain}/public_html/index.html":
    ensure  => 'present',
    replace => 'yes', # this is the important property
    content => "<h1>INSTANCIA1</h1>",
    mode    => '0644',
  }
}

create_index{
  "1" : domain => $app1, index => 1;
}

# class { '::apache': }
#
# # Most basic vhost
# apache::vhost { 'app1.4linux.com.br':
#   port    => '80',
#   docroot => "/var/www/${app1}/public_html",
# }
#
# apache::vhost { 'app2.4linux.com.br':
#   port    => '81',
#   docroot => '/var/www/teste.networkabout.com/public_html',
# }
#
# apache::vhost { 'app3.4linux.com.br':
#   port    => '82',
#   docroot => '/var/www/teste.networkabout.com/public_html',
# }
