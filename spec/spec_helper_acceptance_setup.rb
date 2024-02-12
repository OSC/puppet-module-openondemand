# frozen_string_literal: true

install_module_from_forge('puppetlabs-concat', '>= 9.0.0 < 10.0.0')
install_module_from_forge('puppet-augeasproviders_core', '>= 3.0.0 < 4.0.0')
on hosts, 'puppet config set strict warning'

def supported_releases
  osname = fact('os.name')
  osfamily = fact('os.family')
  osmajor = fact('os.release.major')
  if ['Amazon-2023', 'Debian-12'].include?("#{osname}-#{osmajor}")
    ['3.1']
  elsif "#{osfamily}-#{osmajor}" == 'RedHat-7'
    ['3.0']
  else
    ['3.0', '3.1']
  end
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
openondemand::ssl:
- "SSLCertificateFile /etc/pki/tls/certs/localhost.crt"
- "SSLCertificateKeyFile /etc/pki/tls/private/localhost.key"
    HIERA
    create_remote_file(hosts, '/etc/puppetlabs/puppet/hiera.yaml', hiera_yaml)
    on hosts, 'mkdir -p /etc/puppetlabs/puppet/data'
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
        '--hostname $(hostname) --email root@$(hostname)'
      ]
      on hosts, cert_bootstrap.join(' ')
    end
  end
end
