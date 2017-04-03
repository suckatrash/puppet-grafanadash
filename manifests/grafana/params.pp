class grafanadash::grafana::params {
  $version            = '4.2.0'
  #$download_url       = "http://grafanarel.s3.amazonaws.com/grafana-${version}.tar.gz"
  $download_url       = "https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-${version}.linux-x64.tar.gz"
  $install_dir        = '/opt'
  $symlink            = true
  $symlink_name       = "${install_dir}/grafana"
  $user               = 'root'
  $group              = 'root'
  $graphite_host      = 'localhost'
  $graphite_port      = 80
  $elasticsearch_host = 'localhost'
  $elasticsearch_port = 9200
  $grafana_port       = 10000
  $grafana_host       = 'localhost'
}
