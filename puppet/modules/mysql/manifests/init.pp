class mysql($root_password) {
  package { 'mysql-server':
    ensure => 'installed',
    require => Exec['apt-update'],
  }
  service { 'mysql':
    ensure => 'running',
    require => Package['mysql-server'],
  }
  file { '/root/.mysql-passwd.cnf':
    content => $root_password,
    require => Exec['mysql-passwd'],
  }
  exec { 'mysql-passwd':
    command => "/usr/bin/mysqladmin -u root password $root_password",
    creates => '/root/.mysql-passwd.cnf',
    user => 'root',
    require => Service['mysql'],
  }
}
