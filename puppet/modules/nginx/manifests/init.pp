class nginx {
  package { 'nginx':
    ensure => 'installed',
    require => Exec['apt-update'],
  } ->
  file { '/etc/nginx/sites-available/default':
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  } ->
  file { '/etc/nginx/sites-enabled/default':
    ensure  => 'link',
    target  => '/etc/nginx/sites-available/default',
    require => File['/etc/nginx/sites-available/default'],
  } ->
  service { 'nginx':
    ensure  => 'running',
    require => File['/etc/nginx/sites-enabled/default'],
  }
}
