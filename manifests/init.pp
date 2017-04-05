class grafanadash {

  class { 'epel': } ->

  class { 'graphite':
     gr_web_cors_allow_from_all => true,
     gr_storage_schemas         => [
        {
          name       => 'carbon',
          pattern    => '^carbon\.',
          retentions => '1m:90d'
        },
        {
          name       => 'default',
          pattern    => '.*',
          retentions => '10s:1d,5m:5d,1d:2y'
        }
      ],
  } ->

  class { 'elasticsearch':
    java_install => true,
    manage_repo  => true,
    repo_version => '1.0',
    config => {},
  }

yumrepo { 'grafana-repo':
  ensure        => 'present',
  baseurl       => 'https://packagecloud.io/grafana/stable/el/6/$basearch',
  descr         => 'grafana-repository',
  enabled       => '1',
  repo_gpgcheck => '1',
  gpgcheck      => '1',
  gpgkey        => 'https://packagecloud.io/gpg.key https://grafanarel.s3.amazonaws.com/RPM-GPG-KEY-grafana',
  sslverify     => '1',
  sslcacert     => '/etc/pki/tls/certs/ca-bundle.crt',
}->

package {'grafana':
  ensure        => installed,
}->

service {'grafana-server':
  ensure       => running,
  enable       => true,
}

}
