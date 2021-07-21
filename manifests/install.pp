# @summary Manage Open OnDemand install
# @api private
class openondemand::install {
  assert_private()

  package { 'ondemand':
    ensure => $openondemand::ondemand_package_ensure,
    notify => Exec['ood-portal-generator-generate'],
  }

  # Ensure changes to packaged sudo files and produced rpmnew
  # Are deleted in idempotent way
  include sudo
  Package['ondemand'] -> Class['sudo']

  package { 'ondemand-selinux':
    ensure => $openondemand::selinux_package_ensure,
  }

  if $openondemand::auth_type == 'dex' {
    package { 'ondemand-dex':
      ensure => $openondemand::ondemand_dex_package_ensure,
    }
  }
}
