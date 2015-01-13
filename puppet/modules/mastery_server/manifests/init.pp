class mastery_server($baseDir) {
  file { $baseDir:
    ensure => 'directory',
    notify  => Service['mastery_server'],

    source       => '/opt/repository/server/build/release/',
    sourceselect => 'all',
    recurse      => true,

    owner => 'www-data',
    group => 'www-data',
    mode  => 0644,
  }

  file { '/etc/init/mastery_server.conf':
    source  => 'puppet:///modules/mastery_server/mastery_server.conf',
    require => Class['Nodejs'],

    owner => 'www-data',
    group => 'www-data',
    mode  => 0644,
  }

  service { 'mastery_server':
    ensure   => 'running',
    provider => 'upstart',
    require  => File['/etc/init/mastery_server.conf'],
  }
}

