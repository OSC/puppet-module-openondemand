shared_examples 'openondemand::repo' do |facts|
  it do
    is_expected.to contain_yumrepo('ondemand-web').only_with(
      descr: 'Open OnDemand Web Repo',
      baseurl: "https://yum.osc.edu/ondemand/latest/web/el#{facts[:os]['release']['major']}/$basearch",
      enabled: '1',
      gpgcheck: '1',
      repo_gpgcheck: '1',
      gpgkey: 'https://yum.osc.edu/ondemand/RPM-GPG-KEY-ondemand',
      metadata_expire: '1',
      priority: '99',
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
      gpgkey: 'https://yum.osc.edu/ondemand/RPM-GPG-KEY-ondemand',
      metadata_expire: '1',
      priority: '99',
    )
  end

  if facts[:os]['release']['major'].to_i == 7
    it { is_expected.not_to contain_exec('dnf makecache ondemand-web') }

    if facts[:os]['name'] == 'CentOS'
      it { is_expected.to contain_file('/etc/yum.repos.d/ondemand-centos-scl.repo').with_ensure('absent') }
    else
      it { is_expected.not_to contain_file('/etc/yum.repos.d/ondemand-centos-scl.repo') }
    end

    case facts[:os]['name']
    when 'RedHat'
      it { is_expected.to contain_rh_repo("rhel-server-rhscl-#{facts[:os]['release']['major']}-rpms").with_ensure('present') }
    when 'CentOS'
      it { is_expected.to contain_package('centos-release-scl').with_ensure('installed') }
    end
    it { is_expected.not_to contain_package('nodejs:12') }
    it { is_expected.not_to contain_package('ruby:2.7') }
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

    it do
      is_expected.to contain_package('nodejs').with(
        ensure: '12',
        enable_only: 'true',
        provider: 'dnfmodule',
      )
    end
    it do
      is_expected.to contain_package('ruby').with(
        ensure: '2.7',
        enable_only: 'true',
        provider: 'dnfmodule',
      )
    end
  end

  context 'when manage_dependency_repos => false' do
    let(:params) { { manage_dependency_repos: false } }

    it { is_expected.not_to contain_file('/etc/yum.repos.d/ondemand-centos-scl.repo') }
    it { is_expected.not_to contain_rh_repo("rhel-server-rhscl-#{facts[:os]['release']['major']}-rpms") }
    it { is_expected.not_to contain_package('centos-release-scl') }
  end

  context 'when repo_nightly => true' do
    let(:params) { { repo_nightly: true } }

    it { is_expected.to contain_yumrepo('ondemand-web-nightly').with_ensure('present') }
  end
end
