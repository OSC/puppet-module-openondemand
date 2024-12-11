# @summary Manage Open OnDemand Apache
# @api private
class openondemand::apache {
  assert_private()

  if $openondemand::declare_apache {
    class { 'apache':
      default_vhost => false,
    }
  } else {
    contain apache
  }

  if $facts['os']['family'] == 'RedHat' {
    $session_package = 'mod_session'
    $proxy_html_package = 'mod_proxy_html'
    $openidc_package = 'mod_auth_openidc'
  } else {
    $session_package = undef
    $proxy_html_package = undef
    $openidc_package = undef
  }

  include apache::mod::ssl
  apache::mod { 'session':
    package => $session_package,
  }
  apache::mod { 'session_cookie':
    package => $session_package,
  }
  apache::mod { 'session_dbd':
    package => $session_package,
  }
  apache::mod { 'auth_form':
    package => $session_package,
  }
  # mod_request needed by mod_auth_form - should probably be a default module.
  apache::mod { 'request': }
  # xml2enc and proxy_html work around apache::mod::proxy_html lack of package name parameter
  apache::mod { 'xml2enc': }
  apache::mod { 'proxy_html':
    package => $proxy_html_package,
  }
  include apache::mod::proxy
  include apache::mod::proxy_http
  include apache::mod::proxy_connect
  include apache::mod::proxy_wstunnel
  if $openondemand::auth_type == 'CAS' {
    include apache::mod::auth_cas
  }
  apache::mod { 'lua': }
  include apache::mod::headers
  include apache::mod::rewrite

  if $openondemand::auth_type in ['dex','openid-connect'] {
    apache::mod { 'auth_openidc':
      package        => $openidc_package,
      package_ensure => $openondemand::mod_auth_openidc_ensure,
    }
  }

  systemd::dropin_file { 'ood.conf':
    unit    => "${apache::service_name}.service",
    content => join([
        '[Service]',
        'KillSignal=SIGTERM',
        'KillMode=process',
        'PrivateTmp=false',
        '',
    ], "\n"),
    notify  => Class['apache::service'],
  }
  systemd::dropin_file { 'ood-portal.conf':
    ensure => 'absent',
    unit   => "${apache::service_name}.service",
    notify => Class['apache::service'],
  }
}
