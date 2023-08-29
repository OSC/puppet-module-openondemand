# @summary Manage Open OnDemand cluster definition
#
#
# @param cluster_title
# @param owner
#   Owner of the cluster YAML file
# @param group
#   Group of the cluster YAML file
# @param mode
#   Ownership mode of the cluster YAML file
# @param url
# @param hidden
# @param acls
# @param login_host
# @param job_adapter
# @param job_cluster
# @param job_host
# @param job_lib
# @param job_libdir
# @param job_bin
# @param job_bindir
# @param job_conf
# @param job_envdir
# @param job_serverdir
# @param job_exec
# @param sge_root
# @param libdrmaa_path
# @param job_version
# @param job_bin_overrides
# @param job_submit_host
# @param job_ssh_hosts
# @param job_site_timeout
# @param job_debug
# @param job_singularity_bin
# @param job_singularity_bindpath
# @param job_singularity_image
# @param job_strict_host_checking
# @param job_tmux_bin
# @param job_config_file
# @param job_username_prefix
# @param job_namespace_prefix
# @param job_all_namespaces
# @param job_auto_supplemental_groups
# @param job_server
# @param job_mounts
# @param job_auth
# @param scheduler_type
# @param scheduler_host
# @param scheduler_bin
# @param scheduler_version
# @param scheduler_params
# @param rsv_query_acls
# @param ganglia_host
# @param ganglia_scheme
# @param ganglia_segments
# @param ganglia_req_query
# @param ganglia_opt_query
# @param ganglia_version
# @param grafana_host
# @param grafana_org_id
# @param grafana_theme
# @param grafana_dashboard_name
# @param grafana_dashboard_uid
# @param grafana_dashboard_panels
# @param grafana_labels
# @param grafana_cluster_override
# @param xdmod_resource_id
# @param custom_config
#   Custom Hash passed to `v2.custom` in cluster YAML
# @param batch_connect
#
define openondemand::cluster (
  String $cluster_title = $name,
  String $owner = 'root',
  String $group = 'root',
  Stdlib::Filemode $mode = '0644',
  Optional[Variant[Stdlib::HTTPSUrl, Stdlib::HTTPUrl]] $url = undef,
  Boolean $hidden = false,
  Optional[Array[Openondemand::Acl]] $acls = undef,
  Optional[Stdlib::Host] $login_host = undef,
  Optional[Enum['torque','slurm','lsf','pbspro','sge','linux_host','kubernetes']] $job_adapter = undef,
  Optional[String] $job_cluster = undef,
  Optional[Stdlib::Host] $job_host = undef,
  Optional[Stdlib::Absolutepath] $job_lib = undef,
  Optional[Stdlib::Absolutepath] $job_libdir = undef,
  Optional[Stdlib::Absolutepath] $job_bin = undef,
  Optional[Stdlib::Absolutepath] $job_bindir = undef,
  Optional[Stdlib::Absolutepath] $job_conf = undef,
  Optional[Stdlib::Absolutepath] $job_envdir = undef,
  Optional[Stdlib::Absolutepath] $job_serverdir = undef,
  Optional[Stdlib::Absolutepath] $job_exec = undef,
  Optional[Stdlib::Absolutepath] $sge_root = undef,
  Optional[Stdlib::Absolutepath] $libdrmaa_path = undef,
  Optional[String] $job_version = undef,
  Optional[Hash[String, Stdlib::Absolutepath]] $job_bin_overrides = undef,
  Optional[Stdlib::Host] $job_submit_host = undef,
  Optional[Array[Stdlib::Host]] $job_ssh_hosts = undef,
  Optional[Integer] $job_site_timeout = undef,
  Optional[Boolean] $job_debug = undef,
  Optional[Stdlib::Absolutepath] $job_singularity_bin = undef,
  Optional[Variant[Array[Stdlib::Absolutepath], String]] $job_singularity_bindpath = undef,
  Optional[String] $job_singularity_image = undef,
  Optional[Boolean] $job_strict_host_checking = undef,
  Optional[Stdlib::Absolutepath] $job_tmux_bin = undef,
  # Kubernetes
  Optional[String[1]] $job_config_file = undef,
  Optional[String] $job_username_prefix = undef,
  Optional[String] $job_namespace_prefix = undef,
  Boolean $job_all_namespaces = false,
  Boolean $job_auto_supplemental_groups = false,
  Optional[Openondemand::K8_server] $job_server = undef,
  Optional[Array[Openondemand::K8_mount]] $job_mounts = undef,
  Optional[Openondemand::K8_auth] $job_auth = undef,
  # END Kubernetes
  Optional[Enum['moab']] $scheduler_type = undef,
  Optional[Stdlib::Host] $scheduler_host = undef,
  Optional[Stdlib::Absolutepath] $scheduler_bin = undef,
  Optional[String] $scheduler_version = undef,
  Hash $scheduler_params = {},
  Optional[Array[Openondemand::Acl]] $rsv_query_acls = undef,
  Optional[Stdlib::Host] $ganglia_host = undef,
  String $ganglia_scheme = 'https://',
  Array $ganglia_segments = ['gweb', 'graph.php'],
  Hash $ganglia_req_query = { 'c' => $name },
  Hash $ganglia_opt_query = { 'h' => "%{h}.${facts['networking']['domain']}" },
  String $ganglia_version = '3',
  Optional[Variant[Stdlib::HTTPSUrl,Stdlib::HTTPUrl]] $grafana_host = undef,
  Integer $grafana_org_id = 1,
  Optional[String] $grafana_theme = undef,
  Optional[String] $grafana_dashboard_name = undef,
  Optional[String] $grafana_dashboard_uid = undef,
  Optional[Struct[{
        'cpu' => Integer,
        'memory' => Integer,
  }]] $grafana_dashboard_panels = undef,
  Optional[Struct[{
        'cluster' => String,
        'host' => String,
        'jobid' => Optional[String],
  }]] $grafana_labels = undef,
  Optional[String] $grafana_cluster_override = undef,
  Optional[Integer] $xdmod_resource_id = undef,
  Hash $custom_config = {},
  Optional[Openondemand::Batch_connect] $batch_connect = undef,
) {
  include openondemand

  if $grafana_host {
    if $grafana_dashboard_name == undef or $grafana_dashboard_uid == undef or $grafana_dashboard_panels == undef or $grafana_labels == undef {
      fail('Must define grafana_dashboard_name, grafana_dashboard_uid, grafana_dashboard_panels and grafana_labels')
    }
  }

  if $job_adapter == 'kubernetes' {
    if !$job_server {
      fail('Must define job_server when job_adapter is kubernetes')
    }
    $_job_bin = pick($job_bin, $openondemand::kubectl_path)
  } else {
    $_job_bin = $job_bin
  }

  if $job_singularity_bindpath =~ Array {
    $_job_singularity_bindpath = join($job_singularity_bindpath, ',')
  } else {
    $_job_singularity_bindpath = $job_singularity_bindpath
  }

  $metadata = {
    'title' => $cluster_title,
    'url'   => $url,
    'hidden' => $hidden,
  }.filter |$k,$v| { $v =~ NotUndef }

  if $login_host {
    $login = {
      'host' => $login_host,
    }
  } else {
    $login = undef
  }

  if $job_adapter {
    if $job_adapter == 'kubernetes' {
      $job_kubernetes = {
        'config_file' => $job_config_file,
        'username_prefix' => $job_username_prefix,
        'namespace_prefix'  => $job_namespace_prefix,
        'all_namespaces'    => $job_all_namespaces,
        'auto_supplemental_groups'  => $job_auto_supplemental_groups,
        'server'                    => $job_server,
        'mounts'                    => $job_mounts,
        'auth'                      => $job_auth,
      }.filter |$k,$v| { $v =~ NotUndef }
    } else {
      $job_kubernetes = {}
    }
    $job_base = {
      'adapter'               => $job_adapter,
      'cluster'               => $job_cluster,
      'host'                  => $job_host,
      'lib'                   => $job_lib,
      'libdir'                => $job_libdir,
      'bin'                   => $_job_bin,
      'bindir'                => $job_bindir,
      'conf'                  => $job_conf,
      'envdir'                => $job_envdir,
      'serverdir'             => $job_serverdir,
      'exec'                  => $job_exec,
      'sge_root'              => $sge_root,
      'libdrmaa_path'         => $libdrmaa_path,
      'version'               => $job_version,
      'submit_host'           => $job_submit_host,
      'ssh_hosts'             => $job_ssh_hosts,
      'site_timeout'          => $job_site_timeout,
      'debug'                 => $job_debug,
      'singularity_bin'       => $job_singularity_bin,
      'singularity_bindpath'  => $_job_singularity_bindpath,
      'singularity_image'     => $job_singularity_image,
      'strict_host_checking'  => $job_strict_host_checking,
      'tmux_bin'              => $job_tmux_bin,
      'bin_overrides'         => $job_bin_overrides,
    }.filter |$k,$v| { $v =~ NotUndef }
    $job = $job_base + $job_kubernetes
  } else {
    $job = undef
  }

  if $job_adapter == 'torque' or $scheduler_type or $ganglia_host or $grafana_host or $xdmod_resource_id or ! empty($custom_config) {
    if $job_adapter == 'torque' {
      $pbs = {
        'host'    => $job_host,
        'lib'     => $job_lib,
        'bin'     => $job_bin,
        'version' => $job_version,
      }.filter |$k,$v| { $v =~ NotUndef }
    } else {
      $pbs = undef
    }
    if $scheduler_type == 'moab' {
      $moab = {
        'host'    => $scheduler_host,
        'bin'     => $scheduler_bin,
        'version' => $scheduler_version,
        'homedir' => $scheduler_params['moabhomedir'],
      }.filter |$k,$v| { $v =~ NotUndef }
    } else {
      $moab = undef
    }
    if $job_adapter == 'torque' and $scheduler_type == 'moab' {
      $rsv_query = {
        'torque_host'    => $job_host,
        'torque_lib'     => $job_lib,
        'torque_bin'     => $job_bin,
        'torque_version' => $job_version,
        'moab_host'      => $scheduler_host,
        'moab_bin'       => $scheduler_bin,
        'moab_version'   => $scheduler_version,
        'moab_homedir'   => $scheduler_params['moabhomedir'],
        'acls'           => $rsv_query_acls,
      }.filter |$k,$v| { $v =~ NotUndef }
    } else {
      $rsv_query = undef
    }
    if $ganglia_host {
      $ganglia = {
        'host'      => $ganglia_host,
        'scheme'    => $ganglia_scheme,
        'segments'  => $ganglia_segments,
        'req_query' => $ganglia_req_query,
        'opt_query' => $ganglia_opt_query,
        'version'   => $ganglia_version,
      }.filter |$k,$v| { $v =~ NotUndef }
    } else {
      $ganglia = undef
    }
    if $grafana_host {
      $grafana = {
        'host'              => $grafana_host,
        'orgId'             => $grafana_org_id,
        'theme'             => $grafana_theme,
        'dashboard'         => {
          'name'    => $grafana_dashboard_name,
          'uid'     => $grafana_dashboard_uid,
          'panels'  => $grafana_dashboard_panels,
        },
        'labels'            => $grafana_labels,
        'cluster_override'  => $grafana_cluster_override,
      }
    } else {
      $grafana = undef
    }
    if $xdmod_resource_id {
      $xdmod = {
        'resource_id' => $xdmod_resource_id,
      }
    } else {
      $xdmod = undef
    }
    $custom_base = {
      'pbs'       => $pbs,
      'moab'      => $moab,
      'rsv_query' => $rsv_query,
      'ganglia'   => $ganglia,
      'grafana'   => $grafana,
      'xdmod'     => $xdmod,
    }.filter |$k,$v| { $v =~ NotUndef }
    $custom = $custom_base + $custom_config
  } else {
    $custom = undef
  }

  $v2 = {
    'metadata'      => $metadata,
    'acls'          => $acls,
    'login'         => $login,
    'job'           => $job,
    'custom'        => $custom,
    'batch_connect' => $batch_connect,
  }.filter |$k,$v| { $v =~ NotUndef }

  $config = {
    'v2' => $v2,
  }

  file { "/etc/ood/config/clusters.d/${name}.yml":
    ensure  => 'file',
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => to_yaml($config),
    notify  => Class['openondemand::service'],
  }
}
