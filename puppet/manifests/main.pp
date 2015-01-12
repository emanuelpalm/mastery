exec { 'apt-update':
  command => '/usr/bin/apt-get update',
}

File {
  owner => 'root',
  group => 'root',
  mode => 0644
}

group {
  'www-data': ensure => 'present'
}
user {
  'www-data': ensure => 'present'
}

include motd
include nginx
include nodejs
class { 'mysql':
  root_password => sha1(fqdn_rand(4294967295)),
}

class { 'mastery_client':
  baseDir => '/usr/share/nginx/html',
}
class { 'mastery_account':
  baseDir => '/usr/local/share/mastery/account/',
}

file { '/usr/local/share/mastery/':
  ensure => 'directory',
}

