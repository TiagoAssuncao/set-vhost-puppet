# set-vhost-puppet

[![Puppet Version](https://img.shields.io/badge/puppet%20version-3.7.2-yellow.svg)](https://img.shields.io/badge/puppet%20version-3.7.2-yellow.svg)
[![License](https://img.shields.io/badge/license-GPL%203.0-blue.svg)](https://img.shields.io/badge/license-GPL%203.0-blue.svg)

Process configuration to vhosts Apache using puppet.

## Requirements
You need install puppetlabs-apache

``` bash
puppet module install puppetlabs-apache
```

## Usage
You just need run the puppet file as super user:

``` bash
sudo puppet apply puppet-apache.pp
```

