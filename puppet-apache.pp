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
