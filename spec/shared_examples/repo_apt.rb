shared_examples 'openondemand::repo::apt' do |facts|
  it do
    is_expected.to contain_apt__source('ondemand-web').with(
      ensure: 'present',
      location: 'https://apt.osc.edu/ondemand/2.0/web/apt',
      repos: 'main',
      release: facts[:os]['distro']['codename'],
      key: {
        'id'     => 'FE143EA1CB378B569BBF7C544B72FE2B92D31755',
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
        'id'     => 'FE143EA1CB378B569BBF7C544B72FE2B92D31755',
        'source' => 'https://apt.osc.edu/ondemand/DEB-GPG-KEY-ondemand',
      },
    )
  end

  context 'when repo_nightly => true' do
    let(:params) { { repo_nightly: true } }

    it { is_expected.to contain_apt__source('ondemand-web-nightly').with_ensure('present') }
  end
end
