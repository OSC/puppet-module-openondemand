# @summary Manage Open OnDemand user app
#
# @example
#   openondemand::app::usr { 'user1':
#     gateway_src => '/home/user1/ondemand/usr',
#   }
#
# @param gateway_src
#   Path to source of user's apps
# @param ensure
# @param mode
#   The file mode for shared apps
# @param owner
#   The file owner of shared apps
# @param group
#   The file group owner of shared apps
#
define openondemand::app::usr (
  Stdlib::Absolutepath $gateway_src,
  Enum['present','absent'] $ensure = 'present',
  Stdlib::Filemode $mode = '0750',
  String $owner = 'root',
  String $group = 'root',
) {
  include openondemand

  $base_web_dir = "${openondemand::web_directory}/apps/usr"
  $web_dir      = "${base_web_dir}/${name}"
  $gateway      = "${web_dir}/gateway"

  if $ensure == 'present' {
    file { $web_dir:
      ensure => 'directory',
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }

    file { $gateway:
      ensure => 'link',
      target => $gateway_src,
    }
  }

  if $ensure == 'absent' {
    file { $gateway:
      ensure => 'absent',
    }
    -> file { $web_dir:
      ensure => 'absent',
      force  => true,
    }
  }
}
