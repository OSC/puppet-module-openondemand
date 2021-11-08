require 'spec_helper_acceptance'

describe 'openondemand class:' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'openondemand':
        # TODO: Switch to 2.0 repo once it has Ubuntu packages
        repo_release => 'build/2.0',
      }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'with nightly repo', skip: true do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'openondemand':
        repo_nightly            => true,
        ondemand_package_ensure => 'latest',
      }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe yumrepo('ondemand-web-nightly'), if: fact('os.family') == 'RedHat' do
      it { is_expected.to be_enabled }
    end

    describe command('rpm -q ondemand'), if: fact('os.family') == 'RedHat' do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match(%r{nightly}) }
    end

    describe file('/etc/apt/sources.list.d/ondemand-web-nightly.list'), if: fact('os.family') == 'Debian' do
      it { is_expected.to be_file }
    end
  end
end
