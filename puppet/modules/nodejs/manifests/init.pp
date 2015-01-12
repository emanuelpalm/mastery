class nodejs {
  package { 'nodejs': ensure => 'installed', require => Exec['apt-update'] }
}

