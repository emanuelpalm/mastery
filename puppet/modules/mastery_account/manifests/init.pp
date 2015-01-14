class mastery_account($baseDir, $rootPassword) {
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

  file { '/usr/share/nginx/html/avatars/':
    ensure => 'directory',
    require => Class['Nginx'],

    owner => 'www-data',
    group => 'www-data',
    mode  => 0644,
  }

  exec { 'mysql-setup':
    command => "/usr/bin/mysql -u root -p$rootPassword < $baseDir/setup.sql",
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

