exec { 'apt-update':
  command => '/usr/bin/apt-get update',
}

include motd
include nginx

