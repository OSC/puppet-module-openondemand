# frozen_string_literal: true

shared_examples 'openondemand::repo::rpm' do |facts|
  let(:gpgkey) do
    if facts[:os]['release']['major'].to_i <= 8
      'https://yum.osc.edu/ondemand/RPM-GPG-KEY-ondemand'
    else
      'https://yum.osc.edu/ondemand/RPM-GPG-KEY-ondemand-SHA512'
    end
  end

  it do
    is_expected.to contain_yumrepo('ondemand-web').only_with(
      descr: 'Open OnDemand Web Repo',
      baseurl: "https://yum.osc.edu/ondemand/3.1/web/el#{facts[:os]['release']['major']}/$basearch",
      enabled: '1',
      gpgcheck: '1',
      repo_gpgcheck: '1',
      gpgkey: gpgkey,
      metadata_expire: '1',
      priority: '99',
      exclude: 'absent',
    )
  end

  it do
    is_expected.to contain_yumrepo('ondemand-web-nightly').only_with(
      ensure: 'absent',
      descr: 'Open OnDemand Web Repo - Nightly',
      baseurl: "https://yum.osc.edu/ondemand/nightly/web/el#{facts[:os]['release']['major']}/$basearch",
      enabled: '1',
      gpgcheck: '1',
      repo_gpgcheck: '1',
      gpgkey: gpgkey,
      metadata_expire: '1',
      priority: '99',
    )
  end

  if facts[:os]['release']['major'].to_i == 8
    it do
      is_expected.to contain_exec('dnf makecache ondemand-web').with(
        path: '/usr/bin:/bin:/usr/sbin:/sbin',
        command: "dnf -q makecache -y --disablerepo='*' --enablerepo='ondemand-web'",
        refreshonly: 'true',
        subscribe: 'Yumrepo[ondemand-web]',
      )
    end

    it do
      is_expected.to contain_exec('dnf makecache ondemand-web').that_comes_before('Package[nodejs]')
      is_expected.to contain_exec('dnf makecache ondemand-web').that_comes_before('Package[ruby]')
    end

  end

  if facts[:os]['release']['major'].to_s =~ %r{^(8|9)$}
    it do
      is_expected.to contain_package('nodejs').with(
        ensure: '18',
        enable_only: 'true',
        provider: 'dnfmodule',
      )
    end

    it do
      is_expected.to contain_package('ruby').with(
        ensure: '3.1',
        enable_only: 'true',
        provider: 'dnfmodule',
      )
    end
  end

  if facts[:os]['name'] == 'Amazon'
    it { is_expected.not_to contain_class('epel') }
  else
    it { is_expected.to contain_class('epel') }
  end

  context 'when manage_dependency_repos => false' do
    let(:params) { { manage_dependency_repos: false } }

    it { is_expected.not_to contain_package('nodejs') }
    it { is_expected.not_to contain_package('ruby') }
  end

  context 'when manage_epel => false' do
    let(:params) { { manage_epel: false } }

    it { is_expected.not_to contain_class('epel') }
  end

  context 'when repo_nightly => true' do
    let(:params) { { repo_nightly: true } }

    it { is_expected.to contain_yumrepo('ondemand-web-nightly').with_ensure('present') }
  end
end
