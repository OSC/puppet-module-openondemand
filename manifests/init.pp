# @summary Manage Open OnDemand
#
# @param repo_release
#   The release of OnDemand repo
# @param repo_baseurl_prefix
#   The baseurl prefix for OnDemand repo
# @param repo_gpgkey
#   The URL for OnDemand repo GPG key
# @param manage_scl
#   Boolean that determines if managing SCL
# @param selinux
#   Boolean that determines if adding SELinux support
# @param ondemand_package_ensure
#   ondemand package ensure
# @param mod_auth_openidc_ensure
#   mod_auth_openidc package ensure
# @param install_apps
#   Hash of apps to install, passed to ondemand::install::app
# @param declare_apache
#   Boolean that determines if apache is declared or included
# @param apache_scls
#   SCLs to load when starting Apache service
# @param cilogon_client_id
#   CILogon client_id
# @param cilogon_client_secret
#   CILogon client_secret
# @param oidc_crypto_passphrase
#   OIDC crypto passphrase
# @param listen_addr_port
#   ood_portal.yml listen_addr_port
# @param servername
#   ood_portal.yml servername
# @param ssl
#   ood_portal.yml ssl
# @param logroot
#   ood_portal.yml logroot
# @param use_rewrites
#   ood_portal.yml use_rewrites
# @param use_maintenance
#   ood_portal.yml use_maintenance
# @param maintenance_ip_whitelist
#   ood_portal.yml maintenance_ip_whitelist
# @param maintenance_source
#   Source for maintenance index.html
# @param maintenance_content
#   Content for maintenance index.html
# @param lua_root
#   ood_portal.yml lua_root
# @param lua_log_level
#   ood_portal.yml lua_log_level
# @param user_map_cmd
#   ood_portal.yml user_map_cmd
# @param user_env
#   ood_portal.yml user_env
# @param map_fail_uri
#   ood_portal.yml map_fail_uri
# @param auth_type
#   ood_portal.yml auth_type
# @param auth_configs
#   ood_portal.yml auth_configs
# @param root_uri
#   ood_portal.yml root_uri
# @param analytics
#   ood_portal.yml analytics
# @param public_uri
#   ood_portal.yml public_uri
# @param public_root
#   ood_portal.yml public_root
# @param logout_uri
#   ood_portal.yml logout_uri
# @param logout_redirect
#   ood_portal.yml logout_redirect
# @param host_regex
#   ood_portal.yml host_regex
# @param node_uri
#   ood_portal.yml node_uri
# @param rnode_uri
#   ood_portal.yml rnode_uri
# @param nginx_uri
#   ood_portal.yml nginx_uri
# @param pun_uri
#   ood_portal.yml pun_uri
# @param pun_socket_root
#   ood_portal.yml pun_socket_root
# @param pun_max_retries
#   ood_portal.yml pun_max_retries
# @param oidc_uri
#   ood_portal.yml oidc_uri
# @param oidc_discover_uri
#   ood_portal.yml oidc_discover_uri
# @param oidc_discover_root
#   ood_portal.yml oidc_discover_root
# @param register_uri
#   ood_portal.yml register_uri
# @param register_root
#   ood_portal.yml register_root
# @param oidc_provider
#   OIDC provider
# @param oidc_provider_token_endpoint_auth
#   OIDC provider token_endpoint_auth
# @param oidc_provider_scope
#   OIDC provider scope
# @param oidc_provider_client_id
#   OIDC provider client_id
# @param oidc_provider_client_secret
#   OIDC provider client_secret
# @param oidc_session_inactivity_timeout
#   mod_auth_openidc OIDCSessionInactivityTimeout
# @param oidc_session_max_duration
#   mod_auth_openidc OIDCSessionMaxDuration
# @param oidc_remote_user_claim
#   OIDC provider remote_user claim
# @param oidc_pass_claims_as
#   mod_auth_openidc OIDCPassClaimsAs
# @param oidc_extra_configs
#   OIDC extra settings for mod_auth_openidc
# @param web_directory
#   Path to main web directory for OnDemand
# @param basic_auth_users
#   Hash of resources to pass to httpauth for defining basic auth users
#   Only used with basic auth
# @param nginx_log_group
#   Group to set for /var/log/ondemand-nginx
# @param nginx_stage_ondemand_portal
#   nginx_stage.yml ondemand_portal
# @param nginx_stage_ondemand_title
#   nginx_stage.yml ondemand_title
# @param nginx_stage_pun_custom_env
#   nginx_stage.yml pun_custom_env
# @param nginx_stage_app_root
#   nginx_stage.yml app_root
# @param nginx_stage_scl_env
#   nginx_stage.yml scl_env
# @param nginx_stage_app_request_regex
#   nginx_stage.yml app_request_regex
# @param clusters
#   Hash of resources to apss to openondemand::cluster
# @param clusters_hiera_merge
#   Boolean that determines if clusters should be merged via lookup function
# @param usr_apps
#   Resources passed to openondemand::app::usr
# @param usr_app_defaults
#   Defaults for `usr_apps` resources
# @param dev_apps
#   Resources passed to openondemand::app::dev
# @param dev_app_users
#   Users to define as having dev apps, passed to openondemand::app::dev
# @param dev_app_defaults
#   Defaults for `dev_apps` and `dev_app_users`
# @param apps_config_repo
#   Git repo URL for apps config
# @param apps_config_revision
#   Revision for apps config Git repo
# @param apps_config_repo_path
#   Path in apps config Git repo for app configs
# @param locales_config_repo_path
#   Path in apps config Git repo for locales configs
# @param apps_config_source
#   Source for apps config, not used if `apps_config_repo` is defined
# @param locales_config_source
#   Source for locales config, not used if `apps_config_repo` is defined
# @param public_files_repo_paths
#   Path to public files in apps config Git repo
#
class openondemand (
  # repos
  String $repo_release = 'latest',
  Variant[Stdlib::HTTPSUrl, Stdlib::HTTPUrl]
    $repo_baseurl_prefix = 'https://yum.osc.edu/ondemand',
  Variant[Stdlib::HTTPSUrl, Stdlib::HTTPUrl, Stdlib::Absolutepath]
    $repo_gpgkey = 'https://yum.osc.edu/ondemand/RPM-GPG-KEY-ondemand',
  Boolean $manage_scl = true,

  # packages
  Boolean $selinux = false,
  String $ondemand_package_ensure                 = 'present',
  String $mod_auth_openidc_ensure                 = 'present',
  Hash $install_apps                              = {},

  # Apache
  Boolean $declare_apache = true,
  String $apache_scls = 'httpd24 rh-ruby25',

  # cilogon/oidc
  String $cilogon_client_id      = '',
  String $cilogon_client_secret  = '',
  String $oidc_crypto_passphrase  = 'CHANGEME',

  # ood_portal.yml
  Variant[Array, String, Undef] $listen_addr_port = undef,
  Optional[String] $servername = undef,
  Optional[Array] $ssl = undef,
  String  $logroot = 'logs',
  Boolean $use_rewrites = true,
  Boolean $use_maintenance = true,
  Array $maintenance_ip_whitelist = [],
  Optional[String] $maintenance_source = undef,
  Optional[String] $maintenance_content = undef,
  String $lua_root = '/opt/ood/mod_ood_proxy/lib',
  Optional[String] $lua_log_level = undef,
  String $user_map_cmd  = '/opt/ood/ood_auth_map/bin/ood_auth_map.regex',
  Optional[String] $user_env = undef,
  Optional[String] $map_fail_uri = undef,
  Enum['CAS', 'openid-connect', 'shibboleth', 'ldap', 'basic'] $auth_type = 'ba
  Optional[Array] $auth_configs = undef,
  String $root_uri = '/pun/sys/dashboard',
  Optional[Struct[{url => String, id => String}]] $analytics = undef,
  String $public_uri = '/public',
  String $public_root = '/var/www/ood/public',
  String $logout_uri = '/logout',
  String $logout_redirect = '/pun/sys/dashboard/logout',
  String $host_regex = '[^/]+',
  Optional[String] $node_uri = undef,
  Optional[String] $rnode_uri = undef,
  String $nginx_uri = '/nginx',
  String $pun_uri = '/pun',
  String $pun_socket_root = '/var/run/ondemand-nginx',
  Integer $pun_max_retries = 5,
  Optional[String] $oidc_uri = undef,
  Optional[String] $oidc_discover_uri = undef,
  Optional[String] $oidc_discover_root = undef,
  Optional[String] $register_uri = undef,
  Optional[String] $register_root = undef,

  # OIDC configs
  Optional[String] $oidc_provider = undef,
  Optional[String] $oidc_provider_token_endpoint_auth = undef,
  String $oidc_provider_scope = 'openid email',
  String $oidc_provider_client_id = '',
  String $oidc_provider_client_secret = '',
  Integer $oidc_session_inactivity_timeout = 28800,
  Integer $oidc_session_max_duration = 28800,
  Optional[String] $oidc_remote_user_claim = undef,
  String $oidc_pass_claims_as = 'environment',
  Hash $oidc_extra_configs = {},

  # Misc configs
  Stdlib::Absolutepath $web_directory = '/var/www/ood',
  Hash $basic_auth_users  = {},
  String $nginx_log_group = 'ondemand-nginx',

  # nginx_stage configs
  String $nginx_stage_ondemand_portal = 'ondemand',
  String $nginx_stage_ondemand_title  = 'Open OnDemand',
  Hash $nginx_stage_pun_custom_env = {},
  Openondemand::Nginx_stage_namespace_config $nginx_stage_app_root  = {},
  String $nginx_stage_scl_env = 'ondemand',
  Optional[Openondemand::Nginx_stage_namespace_config] $nginx_stage_app_request_regex = undef,

  # clusters
  Hash $clusters = {},
  Boolean $clusters_hiera_merge = true,

  # usr/dev apps
  Variant[Array, Hash] $usr_apps  = {},
  Hash $usr_app_defaults = {},
  Hash $dev_apps = {},
  Array $dev_app_users = [],
  Hash $dev_app_defaults = {},

  # apps/locales/public configs
  Optional[String] $apps_config_repo = undef,
  Optional[String] $apps_config_revision = undef,
  String $apps_config_repo_path = '',
  Optional[String] $locales_config_repo_path = undef,
  Optional[String] $apps_config_source = undef,
  Optional[String] $locales_config_source = undef,
  Array $public_files_repo_paths = [],
) {

  $osfamily = $facts.dig('os', 'family')
  $_os_release_major = $facts.dig('os', 'release', 'major')

  if $_os_release_major {
    $osmajor = split($_os_release_major, '[.]')[0]
  } else {
    $osmajor = 'Unknown'
  }

  $supported = ['RedHat-7','RedHat-8']
  $os = "${osfamily}-${osmajor}"
  if ! ($os in $supported) {
    fail("Unsupported OS: module ${module_name} only supports RedHat 7 and 8. '${os}' detected")
  }

  if versioncmp($osmajor, '7') <= 0 {
    $scl_apache = true
  } else {
    $scl_apache = false
  }

  if $selinux {
    $selinux_package_ensure = $ondemand_package_ensure
  } else {
    $selinux_package_ensure = 'absent'
  }

  $repo_baseurl = "${repo_baseurl_prefix}/${repo_release}/web/el${osmajor}/\$basearch"

  if $ssl {
    $port = '443'
    $listen_ports = ['443', '80']
    $protocol = 'https'
  } else {
    $port = '80'
    $listen_ports = ['80']
    $protocol = 'http'
  }

  $nginx_stage_cmd = '/opt/ood/nginx_stage/sbin/nginx_stage'
  $pun_stage_cmd = "sudo ${nginx_stage_cmd}"

  case $auth_type {
    'ldap': {
      $auth = ['AuthType basic'] + $auth_configs
    }
    'cilogon': {
      $auth = ['AuthType openid-connect'] + $auth_configs
    }
    # Applies to basic, shibboleth, and openid-connect
    default: {
      $auth = ["AuthType ${auth_type}"] + $auth_configs
    }
  }

  if $apps_config_repo {
    $_public_files_require = Vcsrepo['/opt/ood-apps-config']
  }

  if $apps_config_repo and $apps_config_repo_path {
    $_apps_config_source = "/opt/ood-apps-config/${apps_config_repo_path}"
  } else {
    $_apps_config_source = $apps_config_source
  }

  if $apps_config_repo and $locales_config_repo_path {
    $_locales_config_source = "/opt/ood-apps-config/${locales_config_repo_path}"
  } else {
    $_locales_config_source = $locales_config_source
  }

  if $clusters_hiera_merge {
    $_clusters = lookup('openondemand::clusters', Hash, 'deep', {})
  } else {
    $_clusters = $clusters
  }

  $ood_portal_config = delete_undef_values({
    'listen_addr_port'          => $listen_ports,
    'servername'                => $servername,
    'port'                      => $port,
    'ssl'                       => $ssl,
    'logroot'                   => $logroot,
    'use_rewrites'              => $use_rewrites,
    'use_maintenance'           => $use_maintenance,
    'maintenance_ip_whitelist'  => $maintenance_ip_whitelist,
    'lua_root'                  => $lua_root,
    'lua_log_level'             => $lua_log_level,
    'user_map_cmd'              => $user_map_cmd,
    'user_env'                  => $user_env,
    'map_fail_uri'              => $map_fail_uri,
    'pun_stage_cmd'             => $pun_stage_cmd,
    'auth'                      => $auth,
    'root_uri'                  => $root_uri,
    'analytics'                 => $analytics,
    'public_uri'                => $public_uri,
    'public_root'               => $public_root,
    'logout_uri'                => $logout_uri,
    'logout_redirect'           => $logout_redirect,
    'host_regex'                => $host_regex,
    'node_uri'                  => $node_uri,
    'rnode_uri'                 => $rnode_uri,
    'nginx_uri'                 => $nginx_uri,
    'pun_uri'                   => $pun_uri,
    'pun_socket_root'           => $pun_socket_root,
    'pun_max_retries'           => $pun_max_retries,
    'oidc_uri'                  => $oidc_uri,
    'oidc_discover_uri'         => $oidc_discover_uri,
    'oidc_discover_root'        => $oidc_discover_root,
    'register_uri'              => $register_uri,
    'register_root'             => $register_root,
  })
  $ood_portal_yaml = to_yaml($ood_portal_config)
  $base_apps = {
    'dashboard' => { 'package' => 'ondemand', 'manage_package' => false },
    'shell' => { 'package' => 'ondemand', 'manage_package' => false },
    'files' => { 'package' => 'ondemand', 'manage_package' => false },
    'file-editor' => { 'package' => 'ondemand', 'manage_package' => false },
    'activejobs' => { 'package' => 'ondemand', 'manage_package' => false },
    'myjobs' => { 'package' => 'ondemand', 'manage_package' => false },
    'bc_desktop' => { 'package' => 'ondemand', 'manage_package' => false },
  }

  contain openondemand::repo
  contain openondemand::install
  contain openondemand::apache
  contain openondemand::config
  contain openondemand::service

  Class['openondemand::repo']
  ->Class['openondemand::install']
  ->Class['openondemand::apache']
  ->Class['openondemand::config']
  ->Class['openondemand::service']

  $_clusters.each |$name, $cluster| {
    openondemand::cluster { $name: * => $cluster }
  }

  if $usr_apps =~ Array {
    $usr_apps.each |$usr_app| {
      openondemand::app::usr { $usr_app: * => $usr_app_defaults }
    }
  } else {
    $usr_apps.each |$name, $usr_app| {
      $parameters = $usr_app_defaults + $usr_app
      openondemand::app::usr { $name: * => $parameters }
    }
  }

  $dev_apps.each |$name, $dev_app| {
    $parameters = $dev_app_defaults + $dev_app
    openondemand::app::dev { $name: * => $parameters }
  }

  $dev_app_users.each |$user| {
    openondemand::app::dev { $user:
      * => $dev_app_defaults,
    }
  }

  $apps = deep_merge($base_apps, $install_apps)
  $apps.each |$name, $app| {
    openondemand::install::app { $name: * => $app }
  }

}
