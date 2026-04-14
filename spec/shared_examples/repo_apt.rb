# frozen_string_literal: true

shared_examples 'openondemand::repo::apt' do |facts|
  context 'with repo release default', skip: (facts[:os]['name'] == 'Ubuntu' && facts[:os]['release']['major'] == '22.04') do
    it do
      is_expected.to contain_apt__source('ondemand-web').with(
        ensure: 'present',
        location: 'https://apt.osc.edu/ondemand/4.2/web/apt',
        repos: 'main',
        release: facts[:os]['distro']['codename'],
        key: {
          'name' => 'ondemand-web.gpg',
          'source' => 'https://apt.osc.edu/ondemand/DEB-GPG-KEY-ondemand-SHA512',
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
          'name' => 'ondemand-web-nightly.gpg',
          'source' => 'https://apt.osc.edu/ondemand/DEB-GPG-KEY-ondemand-SHA512',
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
          'name' => 'nodesource.gpg',
          'source' => 'https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key',
        },
      )
    end
  end

  context 'when repo_release => 4.1', skip: (['Ubuntu', 'Debian'].include?(facts[:os]['name']) && ['26.04', '13'].include?(facts[:os]['release']['major'])) do
    let(:param_override) { { repo_release: '4.1' } }

    it do
      is_expected.to contain_apt__source('ondemand-web').with(
        ensure: 'present',
        location: 'https://apt.osc.edu/ondemand/4.1/web/apt',
        repos: 'main',
        release: facts[:os]['distro']['codename'],
        key: {
          'name' => 'ondemand-web.gpg',
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
          'name' => 'nodesource.gpg',
          'source' => 'https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key',
        },
      )
    end
  end

  context 'when repo_nightly => true' do
    let(:param_override) { { repo_nightly: true } }

    it { is_expected.to contain_apt__source('ondemand-web-nightly').with_ensure('present') }
  end
end
