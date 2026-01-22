# frozen_string_literal: true

install_module_from_forge('puppetlabs-concat', '>= 9.0.0 < 10.0.0')
install_module_from_forge('puppet-augeasproviders_core', '>= 3.0.0 < 4.0.0')
on hosts, 'puppet config set strict warning'

def supported_releases
  {
    '4.0' => ['4.0.5', 'latest'],
    # TODO: Reset back to just 4.1.0 once that version is tagged
    '4.1' => ['>=4.1.0', 'latest'],
  }
end

RSpec.configure do |c|
  c.before :suite do
    hiera_yaml = <<-HIERA
---
version: 5
defaults:
  datadir: data
  data_hash: yaml_data
hierarchy:
  - name: os
    path: "%{facts.os.name}.yaml"
  - name: "common"
    path: "common.yaml"
    HIERA
    amazon_yaml = <<-HIERA
# The Apache service won't start during the Docker based tests
apache::service_ensure: stopped
openondemand::ssl:
- "SSLCertificateFile /etc/pki/tls/certs/localhost.crt"
- "SSLCertificateKeyFile /etc/pki/tls/private/localhost.key"
    HIERA
    on hosts, 'mkdir -p /etc/puppetlabs/puppet/data'
    create_remote_file(hosts, '/etc/puppetlabs/puppet/hiera.yaml', hiera_yaml)
    create_remote_file(hosts, '/etc/puppetlabs/puppet/data/Amazon.yaml', amazon_yaml)
    # Need to bootstrap the localhost cert/key
    if fact('os.name') == 'Amazon'
      on hosts, 'dnf install -y sscg'
      cert_bootstrap = [
        'sscg -q',
        '--cert-file /etc/pki/tls/certs/localhost.crt',
        '--cert-key-file /etc/pki/tls/private/localhost.key',
        '--ca-file /etc/pki/tls/certs/localhost.crt',
        '--dhparams-file /tmp/dhparams.pem --lifetime 365',
        '--hostname $(hostname) --email root@$(hostname)',
      ]
      on hosts, cert_bootstrap.join(' ')
    end
  end
end
