# @summary Manage Open OnDemand RPM repos
# @api private
class openondemand::repo::rpm {
  assert_private()

  if $openondemand::repo_nightly {
    exec { 'makecache ondemand-web-nightly':
      path        => '/usr/bin:/bin:/usr/sbin:/sbin',
      command     => "${facts['package_provider']} -q makecache -y --disablerepo='*' --enablerepo='ondemand-web-nightly'",
      refreshonly => true,
      subscribe   => Yumrepo['ondemand-web-nightly'],
    }
  }

  yumrepo { 'ondemand-web':
    descr           => 'Open OnDemand Web Repo',
    baseurl         => $openondemand::repo_baseurl,
    enabled         => '1',
    gpgcheck        => '1',
    repo_gpgcheck   => '1',
    gpgkey          => $openondemand::repo_gpgkey,
    metadata_expire => '1',
    priority        => $openondemand::repo_priority,
    exclude         => $openondemand::repo_exclude,
    proxy           => $openondemand::repo_proxy,
  }

  yumrepo { 'ondemand-web-nightly':
    ensure          => $openondemand::nightly_ensure,
    descr           => 'Open OnDemand Web Repo - Nightly',
    baseurl         => $openondemand::repo_nightly_baseurl,
    enabled         => '1',
    gpgcheck        => '1',
    repo_gpgcheck   => '1',
    gpgkey          => $openondemand::repo_gpgkey,
    metadata_expire => '1',
    priority        => $openondemand::repo_priority,
    proxy           => $openondemand::repo_proxy,
  }

  # Work around a bug where 'dnf module list' is not executed with -y
  if versioncmp($openondemand::osmajor, '8') == 0 {
    exec { 'dnf makecache ondemand-web':
      path        => '/usr/bin:/bin:/usr/sbin:/sbin',
      command     => "dnf -q makecache -y --disablerepo='*' --enablerepo='ondemand-web'",
      refreshonly => true,
      subscribe   => Yumrepo['ondemand-web'],
    }
    if $openondemand::manage_dependency_repos {
      Exec['dnf makecache ondemand-web'] -> Package['nodejs']
      Exec['dnf makecache ondemand-web'] -> Package['ruby']
    }
  }

  if $openondemand::manage_epel {
    contain epel
  }

  if String($openondemand::osmajor) in ['8', '9'] and $openondemand::manage_dependency_repos {
    package { 'nodejs':
      ensure      => '18',
      enable_only => true,
      provider    => 'dnfmodule',
    }
    package { 'ruby':
      ensure      => '3.1',
      enable_only => true,
      provider    => 'dnfmodule',
    }
  }
}
