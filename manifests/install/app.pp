# @summary Manage Open OnDemand app
#
# @example
#   openondemand::install::app { 'bc_osc_foo':
#     ensure => '0.1.0-1.el7',
#   }
#
# @param ensure
#   Package ensure property if installing from a package
# @param package
#   Package name for the app
# @param manage_package
#   Should package be managed
# @param git_repo
#   The git repo to use to install the app
#   If defined, no package will be installed
# @param git_revision
#   The git revision to checkout
# @param path
#   Path to app, defaults to `/var/www/ood/apps/sys/$name`
# @param owner
#   File owner of app
# @param group
#   File group owner of app
# @param mode
#   File mode for app
#
define openondemand::install::app (
  String $ensure = 'present',
  String $package = "ondemand-${name}",
  Boolean $manage_package = true,
  Optional[String] $git_repo = undef,
  Optional[String] $git_revision = undef,
  Optional[Stdlib::Absolutepath] $path = undef,
  String $owner = 'root',
  String $group = 'root',
  String $mode  = '0755',
) {

  include openondemand

  $_path = pick($path, "${openondemand::web_directory}/apps/sys/${name}")

  if $manage_package and ! $git_repo {
    ensure_resource('package', $package, {
      'ensure'  => $ensure,
      'require' => Package['ondemand'],
    })
  }

  if $git_repo {
    vcsrepo { $_path:
      ensure   => $ensure,
      source   => $git_repo,
      revision => $git_revision,
      provider => 'git',
      require  => Package['ondemand'],
    }
  }

  if $ensure != 'absent' {
    file { $_path:
      ensure => 'directory',
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }

    if $manage_package and ! $git_repo {
      Package[$package] -> File[$_path]
    }
    if $git_repo {
      Vcsrepo[$_path] -> File[$_path]
    }
  }

}
