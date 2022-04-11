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
  Optional[Variant[Stdlib::HTTPSUrl, Stdlib::HTTPUrl] ]$url = undef,
  Boolean $hidden = false,
  Array[Openondemand::Acl] $acls = [],
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
  Hash[String, Stdlib::Absolutepath] $job_bin_overrides = {},
  Optional[Stdlib::Host] $job_submit_host = undef,
  Array[Stdlib::Host] $job_ssh_hosts = [],
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
  Array[Openondemand::K8_mount] $job_mounts = [],
  Optional[Openondemand::K8_auth] $job_auth = undef,
  # END Kubernetes
  Optional[Enum['moab']] $scheduler_type = undef,
  Optional[Stdlib::Host] $scheduler_host = undef,
  Optional[Stdlib::Absolutepath] $scheduler_bin = undef,
  Optional[String] $scheduler_version = undef,
  Hash $scheduler_params = {},
  Array[Openondemand::Acl] $rsv_query_acls = [],
  Optional[Stdlib::Host] $ganglia_host = undef,
  String $ganglia_scheme = 'https://',
  Array $ganglia_segments = ['gweb', 'graph.php'],
  Hash $ganglia_req_query = {'c' => $name},
  Hash $ganglia_opt_query = {'h' => "%{h}.${::domain}"},
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
  Openondemand::Batch_connect $batch_connect = {},
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


  file { "/etc/ood/config/clusters.d/${name}.yml":
    ensure  => 'file',
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template('openondemand/cluster/main.yml.erb'),
    notify  => Class['openondemand::service'],
  }

}
