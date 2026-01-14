# frozen_string_literal: true

shared_examples 'openondemand::repo::apt' do |facts|
  it do
    is_expected.to contain_apt__source('ondemand-web').with(
      ensure: 'present',
      location: 'https://apt.osc.edu/ondemand/4.1/web/apt',
      repos: 'main',
      release: facts[:os]['distro']['codename'],
      key: {
        'id' => 'FE143EA1CB378B569BBF7C544B72FE2B92D31755',
        'source' => 'https://apt.osc.edu/ondemand/DEB-GPG-KEY-ondemand',
      },
    )
  end

  it do
    is_expected.to contain_apt__source('ondemand-web-nightly').with(
      ensure: 'absent',
      location: 'https://apt.osc.edu/ondemand/nightly/web/apt',
      repos: 'main',
      release: facts[:os]['distro']['codename'],
      key: {
        'id' => 'FE143EA1CB378B569BBF7C544B72FE2B92D31755',
        'source' => 'https://apt.osc.edu/ondemand/DEB-GPG-KEY-ondemand',
      },
    )
  end

  it do
    is_expected.to contain_apt__source('nodesource').with(
      ensure: 'present',
      location: 'https://deb.nodesource.com/node_22.x',
      repos: 'main',
      release: 'nodistro',
      key: {
        'id' => '6F71F525282841EEDAF851B42F59B5F99B1BE0B4',
        'source' => 'https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key',
      },
    )
  end

  context 'when repo_release => 4.0' do
    let(:params) { { repo_release: '4.0' } }

    it do
      is_expected.to contain_apt__source('nodesource').with(
        ensure: 'present',
        location: 'https://deb.nodesource.com/node_20.x',
        repos: 'main',
        release: 'nodistro',
        key: {
          'id' => '6F71F525282841EEDAF851B42F59B5F99B1BE0B4',
          'source' => 'https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key',
        },
      )
    end
  end

  context 'when repo_nightly => true' do
    let(:params) { { repo_nightly: true } }

    it { is_expected.to contain_apt__source('ondemand-web-nightly').with_ensure('present') }
  end
end
