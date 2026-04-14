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
      'name'   => 'ondemand-web.gpg',
      'source' => $openondemand::_repo_gpgkey,
    },
  }

  apt::source { 'ondemand-web-nightly':
    ensure   => $openondemand::nightly_ensure,
    location => $openondemand::repo_nightly_baseurl,
    repos    => 'main',
    release  => $facts['os']['distro']['codename'],
    key      => {
      'name'   => 'ondemand-web-nightly.gpg',
      'source' => $openondemand::repo_gpgkey,
    },
  }

  apt::source { 'nodesource':
    ensure   => 'present',
    location => "https://deb.nodesource.com/node_${openondemand::nodejs}.x",
    repos    => 'main',
    release  => 'nodistro',
    key      => {
      'name'   => 'nodesource.gpg',
      'source' => 'https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key',
    },
  }
}
