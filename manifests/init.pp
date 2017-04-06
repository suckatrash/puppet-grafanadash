class grafanadash {

## Want to add a datasource with this and the exec below and need to hack on this some more
#$commandfile = '/root/sql.sql'

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
  
#  exec { "add graphite datasource":
#    command => "cat ${commandfile} | sqlite3 /var/lib/grafana/grafana.db",
#    path        => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
#    refreshonly => true,
#  }->

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
