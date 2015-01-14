class mysql($rootPassword) {
  package { 'mysql-server':
    ensure  => 'installed',
    require => Exec['apt-update'],
  }
  service { 'mysql':
    ensure  => 'running',
    require => Package['mysql-server'],
  }
  file { '/root/.mysql-passwd.cnf':
    ensure  => 'present',
    content => $rootPassword,
    owner   => 'root',
    require => Exec['mysql-passwd'],
  }
  exec { 'mysql-passwd':
    command => "/usr/bin/mysqladmin -u root password $rootPassword",
    creates => '/root/.mysql-passwd.cnf',
    user    => 'root',
    require => Service['mysql'],
  }
}
