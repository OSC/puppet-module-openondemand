require 'spec_helper_acceptance'

describe 'openondemand class:' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'openondemand':
        #TODO: Remove repo_release once 2.1 repo exists
        repo_release       => 'latest',
        generator_insecure => true,
      }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'with nightly repo' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'openondemand':
        #TODO: Remove repo_release once 2.1 repo exists
        repo_release            => 'latest',
        repo_nightly            => true,
        ondemand_package_ensure => 'latest',
        generator_insecure      => true,
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
