# @summary Manage Open OnDemand service
# @api private
class openondemand::service {
  assert_private()

  exec { 'nginx_stage-app_clean':
    command     => '/opt/ood/nginx_stage/sbin/nginx_stage app_clean &>/dev/null',
    refreshonly => true,
    subscribe   => [
      File['/etc/ood/config/nginx_stage.yml'],
      File['/etc/ood/profile'],
      File['/etc/ood/config/apps'],
    ],
  }
  -> exec { 'nginx_stage-app_reset-pun':
    command     => '/opt/ood/nginx_stage/sbin/nginx_stage app_reset --sub-uri=/pun &>/dev/null',
    refreshonly => true,
    subscribe   => [
      File['/etc/ood/config/nginx_stage.yml'],
      File['/etc/ood/profile'],
      File['/etc/ood/config/apps'],
    ],
  }
  -> exec { 'nginx_stage-nginx_clean':
    command     => '/opt/ood/nginx_stage/sbin/nginx_stage nginx_clean &>/dev/null',
    refreshonly => true,
    subscribe   => [
      File['/etc/ood/config/nginx_stage.yml'],
      File['/etc/ood/profile'],
      File['/etc/ood/config/apps'],
    ],
  }

  if $openondemand::auth_type == 'dex' {
    service { 'ondemand-dex':
      ensure    => 'running',
      enable    => true,
      subscribe => [
        Exec['ood-portal-generator-generate'],
        File['/etc/ood/dex/config.yaml'],
      ],
    }
  }
}
