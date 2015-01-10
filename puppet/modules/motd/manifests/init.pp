class motd($message = 'Mastery Server\n') {
  File { owner => 0, group => 0, mode => 0644 }
  file { '/etc/motd':
    content => $message,
  }
}
