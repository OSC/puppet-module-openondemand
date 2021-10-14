require 'spec_helper_acceptance'

describe 'openondemand class:' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'openondemand': }
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

    describe yumrepo('ondemand-web-nightly') do
      it { is_expected.to be_enabled }
    end

    describe command('rpm -q ondemand') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match(%r{nightly}) }
    end
  end
end
