# @summary Manage Open OnDemand dev app
#
# @example
#   openondemand::app::dev { 'user1': }
#
# @param ensure
# @param mode
#   File mode of dev app
# @param owner
#   Owner of dev app
# @param group
#   Group owning dev app
# @param home_subdir
#   The subdirectory under user's home for dev app
#   Not used if `gateway_src` is defined
# @param gateway_src
#   The path to dev app, overrides `home_subdir`
define openondemand::app::dev (
  Enum['present','absent'] $ensure = 'present',
  Stdlib::Filemode $mode = '0755',
  String $owner = 'root',
  String $group = 'root',
  String $home_subdir = 'ondemand/dev',
  Optional[Stdlib::Absolutepath] $gateway_src = undef,
) {
  include openondemand

  $base_web_dir = "${openondemand::web_directory}/apps/dev"
  $web_dir      = "${base_web_dir}/${name}"
  $gateway      = "${web_dir}/gateway"
  $_gateway_src  = pick($gateway_src, "~${name}/${home_subdir}")

  if $ensure == 'present' {
    file { $web_dir:
      ensure => 'directory',
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }

    exec { "openondemand::app::dev-link-gateway-${name}":
      path    => '/usr/bin:/bin:/usr/sbin:/sbin',
      command => "ln -snf ${_gateway_src} ${gateway}",
      unless  => [
        "test -L ${gateway}",
        "readlink ${gateway} | grep -q ${_gateway_src}",
      ],
      require => File[$web_dir],
    }
  }

  if $ensure == 'absent' {
    exec { "openondemand::app::dev-unlink-gateway-${name}":
      path    => '/usr/bin:/bin:/usr/sbin:/sbin',
      command => "unlink ${gateway}",
      onlyif  => "test -L ${gateway}",
      before  => File[$web_dir],
    }
    file { $web_dir:
      ensure => 'absent',
      force  => true,
    }
  }
}
