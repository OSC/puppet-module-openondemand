# frozen_string_literal: true

on hosts, 'puppet config set strict warning'

def versions(repo_release)
  if repo_release =~ %r{4.1}
    ['4.1.3', 'latest']
  else
    ['4.2.1', 'latest']
  end
end

RSpec.configure do |c|
  c.add_setting :repo_release
  c.repo_release = ENV['BEAKER_repo_release'] || '4.2'
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
