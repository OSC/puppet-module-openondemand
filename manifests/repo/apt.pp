# @summary Manage Open OnDemand APT repos
# @api private
class openondemand::repo::apt {
  assert_private()

  apt::source { 'ondemand-web':
    ensure   => 'present',
    location => $openondemand::repo_baseurl,
    repos    => 'main',
    release  => $facts['os']['distro']['codename'],
    key      => {
      'id'     => 'FE143EA1CB378B569BBF7C544B72FE2B92D31755',
      'source' => $openondemand::repo_gpgkey,
    },
  }

  apt::source { 'ondemand-web-nightly':
    ensure   => $openondemand::nightly_ensure,
    location => $openondemand::repo_nightly_baseurl,
    repos    => 'main',
    release  => $facts['os']['distro']['codename'],
    key      => {
      'id'     => 'FE143EA1CB378B569BBF7C544B72FE2B92D31755',
      'source' => $openondemand::repo_gpgkey,
    },
  }

  apt::source { 'nodesource':
    ensure   => 'present',
    location => "https://deb.nodesource.com/node_${openondemand::nodejs}.x",
    repos    => 'main',
    release  => 'nodistro',
    key      => {
      'id'     => '6F71F525282841EEDAF851B42F59B5F99B1BE0B4',
      'source' => 'https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key',
    },
  }
}
