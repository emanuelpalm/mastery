stage { 'last': }
Stage['main'] -> Stage['last']

exec { 'apt-update':
  command => '/usr/bin/apt-get update',
}

File {
  owner => 'root',
  group => 'root',
  mode  => 0644,
}

group {
  'www-data': ensure => 'present',
}
user {
  'www-data': ensure => 'present',
}

$mysqlPassword = sha1(fqdn_rand(4294967295))

include motd
include nginx
include nodejs
class { 'mysql':
  rootPassword => $mysqlPassword,
}

class { 'mastery_client':
  baseDir => '/usr/share/nginx/html',
  require => Class['nginx'],
  stage   => 'last',
}
class { 'mastery_account':
  baseDir      => '/usr/local/share/mastery/account/',
  rootPassword => $mysqlPassword,
  require      => [ Class['nodejs'], Class['mysql'] ],
  stage        => 'last',
}
class { 'mastery_server':
  baseDir => '/usr/local/share/mastery/server/',
  require => Class['nodejs'],
  stage   => 'last',
}

file { '/usr/local/share/mastery/':
  ensure => 'directory',
}

