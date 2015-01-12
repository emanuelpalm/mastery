class nginx {
  package { 'nginx':    ensure => 'installed', require => Exec['apt-update'] }
  service { 'nginx':    ensure => 'running' }

  file { '/etc/nginx/sites-available/default':
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  file { '/etc/nginx/sites-enabled/default':
    ensure => 'link',
    target => '/etc/nginx/sites-available/default',
  }
}
