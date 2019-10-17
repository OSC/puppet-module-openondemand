# @summary Manage Open OnDemand configs
# @api private
class openondemand::config {
  assert_private()

  # Assumes /var/www - must create since httpd24 does not
  $web_directory_parent = dirname($openondemand::web_directory)
  if ! defined(File[$web_directory_parent]) {
    file { '/var/www':
      ensure => 'directory',
      path   => $web_directory_parent,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
  }

  file { '/var/www/ood':
    ensure => 'directory',
    path   => $openondemand::web_directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/var/www/ood/apps':
    ensure => 'directory',
    path   => "${openondemand::web_directory}/apps",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/var/www/ood/apps/sys':
    ensure => 'directory',
    path   => "${openondemand::web_directory}/apps/sys",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/var/www/ood/apps/usr':
    ensure  => 'directory',
    path    => "${openondemand::web_directory}/apps/usr",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    purge   => true,
    force   => true,
  }

  file { '/var/www/ood/apps/dev':
    ensure  => 'directory',
    path    => "${openondemand::web_directory}/apps/dev",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    purge   => true,
    force   => true,
  }

  file { '/var/www/ood/public':
    ensure => 'directory',
    path   => $openondemand::public_root,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/ood':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/ood/config':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  if $openondemand::apps_config_repo {
    vcsrepo { '/opt/ood-apps-config':
      ensure   => 'latest',
      provider => 'git',
      source   => $openondemand::apps_config_repo,
      revision => $openondemand::apps_config_revision,
      user     => 'root',
      before   => [
        File['/etc/ood/config/apps'],
        File['/etc/ood/config/locales'],
      ],
    }
  }
  file { '/etc/ood/config/apps':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    source  => $openondemand::_apps_config_source,
    recurse => true,
    purge   => true,
    force   => true,
  }
  file { '/etc/ood/config/locales':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    source  => $openondemand::_locales_config_source,
    recurse => true,
    purge   => true,
    force   => true,
  }

  $openondemand::public_files_repo_paths.each |$path| {
    $basename = basename($path)
    file { "${openondemand::public_root}/${basename}":
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => "/opt/ood-apps-config/${path}",
      require => $openondemand::_public_files_require,
    }
  }

  file { '/etc/ood/config/clusters.d':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    purge   => true,
    recurse => true,
    notify  => Class['openondemand::service'],
  }

  file { '/etc/ood/config/ood_portal.yml':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "# File managed by Puppet - do not edit!\n${openondemand::ood_portal_yaml}",
    notify  => Exec['ood-portal-generator-generate'],
  }

  exec { 'ood-portal-generator-generate':
    command     => '/opt/ood/ood-portal-generator/bin/generate -o /etc/ood/config/ood-portal.conf',
    refreshonly => true,
    before      => ::Apache::Custom_config['ood-portal'],
  }

  include ::apache::params
  ::apache::custom_config { 'ood-portal':
    source         => '/etc/ood/config/ood-portal.conf',
    filename       => 'ood-portal.conf',
    verify_command => $::apache::params::verify_command,
  }

  file { '/etc/ood/config/nginx_stage.yml':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('openondemand/nginx_stage.yml.erb'),
  }

  file { '/etc/ood/profile':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('openondemand/profile.erb'),
  }

  sudo::conf { 'ood':
    content        => template('openondemand/sudo.erb'),
    sudo_file_name => 'ood',
  }

  file { '/etc/cron.d/ood':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('openondemand/ood-cron.erb'),
  }

  logrotate::rule { 'ood':
    path         => ['/var/log/ondemand-nginx/*/access.log', '/var/log/ondemand-nginx/*/error.log'],
    compress     => true,
    missingok    => true,
    copytruncate => true,
    ifempty      => false,
    rotate       => 52,
    rotate_every => 'week',
  }

  file { '/var/log/ondemand-nginx':
    ensure => 'directory',
    mode   => '0750',
    group  => $openondemand::nginx_log_group,
  }

}
