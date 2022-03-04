# @summary Manage Open OnDemand repos
# @api private
class openondemand::repo {
  assert_private()

  if $openondemand::repo_nightly {
    $nightly_ensure = 'present'
    exec { 'makecache ondemand-web-nightly':
      path        => '/usr/bin:/bin:/usr/sbin:/sbin',
      command     => "${facts['package_provider']} -q makecache -y --disablerepo='*' --enablerepo='ondemand-web-nightly'",
      refreshonly => true,
      subscribe   => Yumrepo['ondemand-web-nightly'],
    }
  } else {
    $nightly_ensure = 'absent'
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
  }

  yumrepo { 'ondemand-web-nightly':
    ensure          => $nightly_ensure,
    descr           => 'Open OnDemand Web Repo - Nightly',
    baseurl         => $openondemand::repo_nightly_baseurl,
    enabled         => '1',
    gpgcheck        => '1',
    repo_gpgcheck   => '1',
    gpgkey          => $openondemand::repo_gpgkey,
    metadata_expire => '1',
    priority        => $openondemand::repo_priority,
  }

  # Work around a bug where 'dnf module list' is not executed with -y
  if versioncmp($openondemand::osmajor, '8') >= 0 {
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

  if versioncmp($openondemand::osmajor, '7') <= 0 and $openondemand::manage_dependency_repos {
    contain epel

    if $facts['os']['name'] == 'CentOS' and versioncmp($openondemand::osmajor, '7') == 0 {
      file { '/etc/yum.repos.d/ondemand-centos-scl.repo':
        ensure => 'absent',
      }
    }

    case $facts['os']['name'] {
      'RedHat': {
        rh_repo { "rhel-server-rhscl-${openondemand::osmajor}-rpms":
          ensure => 'present',
        }
      }
      'CentOS': {
        package { 'centos-release-scl':
          ensure => 'installed',
        }
      }
      default: {
        # Do nothing
      }
    }
  }

  if versioncmp($openondemand::osmajor, '8') >= 0 and $openondemand::manage_dependency_repos {
    package { 'nodejs':
      ensure      => '12',
      enable_only => true,
      provider    => 'dnfmodule',
    }
    package { 'ruby':
      ensure      => '2.7',
      enable_only => true,
      provider    => 'dnfmodule',
    }
  }

}
