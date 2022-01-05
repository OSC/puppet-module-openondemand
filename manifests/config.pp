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

  file { '/var/www/ood/public/maintenance':
    ensure => 'directory',
    path   => "${openondemand::public_root}/maintenance",
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/var/www/ood/public/maintenance/index.html':
    ensure  => 'file',
    path    => "${openondemand::public_root}/maintenance/index.html",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => $openondemand::maintenance_source,
    content => $openondemand::maintenance_content,
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

  file { '/etc/ood/config/ondemand.d':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => $openondemand::config_dir_purge,
    force   => $openondemand::config_dir_purge,
    purge   => $openondemand::config_dir_purge,
    notify  => Class['openondemand::service'],
  }

  if ! empty($openondemand::ondemand_config) {
    if $openondemand::config_source !~ Undef {
      $config_source = $openondemand::config_source
      $config_content = undef
      $config_data = undef
    } elsif $openondemand::config_content !~ Undef {
      $config_source = undef
      $config_content = $openondemand::config_content
      $config_data = undef
    } else {
      $config_source = undef
      $config_content = undef
      $config_data = $openondemand::ondemand_config
    }
    openondemand::conf { 'ondemand':
      source  => $config_source,
      content => $config_content,
      data    => $config_data,
    }
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

  file { '/etc/ood/config/announcements.d':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    source  => $openondemand::_announcements_config_source,
    recurse => $openondemand::announcements_purge,
    purge   => $openondemand::announcements_purge,
    force   => $openondemand::announcements_purge,
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
    ensure    => 'file',
    owner     => 'root',
    group     => 'root',
    mode      => '0600',
    content   => "# File managed by Puppet - do not edit!\n${openondemand::ood_portal_yaml}",
    show_diff => false,
    notify    => Exec['ood-portal-generator-generate'],
  }
  $generate = '/opt/ood/ood-portal-generator/bin/generate -o /etc/ood/config/ood-portal.conf -d /etc/ood/dex/config.yaml'
  exec { 'ood-portal-generator-generate':
    path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    command     => $generate,
    refreshonly => true,
    before      => ::Apache::Custom_config['ood-portal'],
  }
  exec { 'ood-portal-generator-generate-refresh':
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    command => $generate,
    creates => '/etc/ood/config/ood-portal.conf',
    before  => ::Apache::Custom_config['ood-portal'],
  }

  include ::apache::params
  ::apache::custom_config { 'ood-portal':
    source         => '/etc/ood/config/ood-portal.conf',
    filename       => 'ood-portal.conf',
    verify_command => "${apache::params::verify_command} || { /bin/rm -f /etc/ood/config/ood-portal.conf; exit 1; }",
    show_diff      => false,
    owner          => 'root',
    group          => $apache::params::group,
    file_mode      => '0640',
  }

  if $openondemand::auth_type == 'dex' {
    file { '/etc/ood/dex/config.yaml':
      ensure  => 'file',
      owner   => 'ondemand-dex',
      group   => 'ondemand-dex',
      mode    => '0600',
      require => Exec['ood-portal-generator-generate']
    }
  }

  file { '/etc/ood/config/nginx_stage.yml':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('openondemand/nginx_stage.yml.erb'),
  }

  if $openondemand::hook_env and $openondemand::pun_pre_hook_root_cmd {
    $hook_env_default = {
      'CLIENT_ID' => $openondemand::oidc_client_id,
      'CLIENT_SECRET' => $openondemand::oidc_client_secret,
    }.filter |$key,$value| { $value =~ NotUndef }
    $hook_env_config = $hook_env_default + $openondemand::hook_env_config
    $hook_env = $hook_env_config.map |$key,$value| { "${key}=\"${value}\"" }
    $hook_env_content = join($hook_env, "\n")

    file { $openondemand::hook_env_path:
      ensure    => 'file',
      owner     => 'root',
      group     => 'root',
      mode      => '0600',
      show_diff => false,
      content   => $hook_env_content,
    }
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

  if $openondemand::manage_logrotate {
    logrotate::rule { 'ood':
      path         => ['/var/log/ondemand-nginx/*/access.log', '/var/log/ondemand-nginx/*/error.log'],
      compress     => true,
      missingok    => true,
      copytruncate => true,
      ifempty      => false,
      rotate       => 52,
      rotate_every => 'week',
    }
  }

  file { '/var/log/ondemand-nginx':
    ensure => 'directory',
    mode   => '0750',
    group  => $openondemand::nginx_log_group,
  }

}
