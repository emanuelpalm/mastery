class nginx {
  group   { 'www-data': ensure => 'present' }
  user    { 'www-data': ensure => 'present' }
  package { 'nginx':    ensure => 'installed', require => Exec['apt-update'] }
  service { 'nginx':    ensure => 'running' }

  File { owner => 0, group => 0, mode => 0644 }
  file { '/etc/nginx/sites-available/default':
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  file { '/etc/nginx/sites-enabled/default':
    ensure => 'link',
    target => '/etc/nginx/sites-available/default',
  }
}
