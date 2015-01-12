class mastery_client($baseDir) {
  file  { $baseDir:
    ensure       => 'directory',

    source       => '/opt/repository/client/build/release/',
    sourceselect => 'all',
    recurse      => true,

    owner        => 'www-data',
    group        => 'www-data',
    mode         => 0644,
  }
}
