$app1 = 'app1.linux.com.br'
$app2 = 'app2.linux.com.br'
$app3 = 'app3.linux.com.br'

class create_index{
  # create a directory      
  file {["/var/www/${app1}", "/var/www/${app1}/public_html"]:

    ensure => 'directory',
    recurse => true,
  }

  file { "/var/www/${app1}/public_html/index.html":
    ensure  => 'present',
    replace => 'no', # this is the important property
    content => "<h1>INSTANCIA1</h1>",
    mode    => '0644',
  }
}

include create_index

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
