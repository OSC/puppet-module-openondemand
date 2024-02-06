# frozen_string_literal: true

shared_examples 'openondemand::repo::rpm' do |facts|
  let(:repo_release) do
    if facts[:os]['release']['major'].to_i == 7
      '3.0'
    else
      '3.1'
    end
  end
  let(:dist) do
    if facts[:os]['name'] == 'Amazon'
      "amzn#{facts[:os]['release']['major']}"
    else
      "el#{facts[:os]['release']['major']}"
    end
  end
  let(:gpgkey) do
    if facts[:os]['release']['major'].to_i <= 8
      'https://yum.osc.edu/ondemand/RPM-GPG-KEY-ondemand'
    else
      'https://yum.osc.edu/ondemand/RPM-GPG-KEY-ondemand-SHA512'
    end
  end
  let(:module_hotfixes) do
    if facts[:os]['release']['major'].to_i == 8
      'true'
    else
      nil
    end
  end

  it do
    is_expected.to contain_yumrepo('ondemand-web').only_with(
      descr: 'Open OnDemand Web Repo',
      baseurl: "https://yum.osc.edu/ondemand/#{repo_release}/web/#{dist}/$basearch",
      enabled: '1',
      gpgcheck: '1',
      repo_gpgcheck: '1',
      gpgkey: gpgkey,
      metadata_expire: '1',
      priority: '99',
      exclude: 'absent',
      module_hotfixes: module_hotfixes,
    )
  end

  it do
    is_expected.to contain_yumrepo('ondemand-web-nightly').only_with(
      ensure: 'absent',
      descr: 'Open OnDemand Web Repo - Nightly',
      baseurl: "https://yum.osc.edu/ondemand/nightly/web/#{dist}/$basearch",
      enabled: '1',
      gpgcheck: '1',
      repo_gpgcheck: '1',
      gpgkey: gpgkey,
      metadata_expire: '1',
      priority: '99',
      module_hotfixes: module_hotfixes,
    )
  end

  if facts[:os]['release']['major'].to_i != 7
    it do
      is_expected.to contain_exec('dnf makecache ondemand-web').with(
        path: '/usr/bin:/bin:/usr/sbin:/sbin',
        command: "dnf -q makecache -y --disablerepo='*' --enablerepo='ondemand-web'",
        refreshonly: 'true',
        subscribe: 'Yumrepo[ondemand-web]',
      )
    end
  else
    it { is_expected.not_to contain_exec('dnf makecache ondemand-web') }
  end

  if facts[:os]['release']['major'].to_i == 7
    case facts[:os]['name']
    when 'RedHat'
      it { is_expected.to contain_rh_repo("rhel-server-rhscl-#{facts[:os]['release']['major']}-rpms").with_ensure('present') }
    when 'CentOS'
      it { is_expected.to contain_package('centos-release-scl').with_ensure('installed') }
    end
    it { is_expected.not_to contain_package('nodejs:14') }
    it { is_expected.not_to contain_package('ruby:3.0') }
    it { is_expected.not_to contain_package('nodejs:18') }
    it { is_expected.not_to contain_package('ruby:3.1') }
  end

  if facts[:os]['release']['major'].to_s =~ %r{^(8|9)$}
    it do
      is_expected.to contain_package('nodejs').with(
        ensure: '18',
        enable_only: 'true',
        provider: 'dnfmodule',
        require: 'Exec[dnf makecache ondemand-web]',
      )
    end

    it do
      is_expected.to contain_package('ruby').with(
        ensure: '3.1',
        enable_only: 'true',
        provider: 'dnfmodule',
        require: 'Exec[dnf makecache ondemand-web]',
      )
    end

    context 'when repo_release => 3.0' do
      let(:params) { { repo_release: '3.0' } }

      if facts[:os]['release']['major'].to_s == '9'
        it { is_expected.to contain_package('nodejs').with_ensure('absent') }
        it { is_expected.to contain_package('ruby').with_ensure('3.1') }
      else
        it { is_expected.to contain_package('nodejs').with_ensure('14') }
        it { is_expected.to contain_package('ruby').with_ensure('3.0') }
      end
    end
  end

  if facts[:os]['name'] == 'Amazon'
    it { is_expected.not_to contain_class('epel') }
  else
    it { is_expected.to contain_class('epel') }
  end

  context 'when manage_dependency_repos => false' do
    let(:params) { { manage_dependency_repos: false } }

    it { is_expected.not_to contain_rh_repo("rhel-server-rhscl-#{facts[:os]['release']['major']}-rpms").with_ensure('present') }
    it { is_expected.not_to contain_package('centos-release-scl').with_ensure('installed') }
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
