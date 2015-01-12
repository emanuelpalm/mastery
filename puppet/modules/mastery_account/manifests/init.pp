class mastery_account($baseDir) {
  file { $baseDir:
    ensure => 'directory',
    notify  => Service['mastery_account'],

    source       => '/opt/repository/account/build/release/',
    sourceselect => 'all',
    recurse      => true,

    owner => 'www-data',
    group => 'www-data',
    mode  => 0644,
  }

  file { '/etc/init/mastery_account.conf':
    source  => 'puppet:///modules/mastery_account/mastery_account.conf',
    require => Class['Nodejs'],

    owner => 'www-data',
    group => 'www-data',
    mode  => 0644,
  }

  file { '/var/mastery/':
    ensure => 'directory',

    owner => 'www-data',
    group => 'www-data',
    mode  => 0644,
  }
  file { '/var/mastery/avatars/':
    ensure => 'directory',
    require => File['/var/mastery/'],

    owner => 'www-data',
    group => 'www-data',
    mode  => 0644,
  }

  $root_password = file('/root/.mysql-passwd.cnf')
  exec { 'mysql-setup':
    command => "/usr/bin/mysql -u root -p$root_password < $baseDir/setup.sql",
    require => Class['Mysql'],
  }

  service { 'mastery_account':
    ensure   => 'running',
    provider => 'upstart',
    require  => [
      File['/etc/init/mastery_account.conf'],
      Exec['mysql-setup'],
    ],
  }
}

