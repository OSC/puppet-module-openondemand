# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'openondemand class:' do
  supported_releases.each do |release|
    context "when repo_release => 'staging/#{release}'" do
      it 'runs successfully' do
        pp = <<-PP
        class { 'openondemand':
          repo_release       => 'staging/#{release}',
          generator_insecure => true,
        }
        PP

        apply_manifest(pp, catch_failures: true)
        apply_manifest(pp, catch_changes: true)
      end
    end
  end

  context 'with nightly repo', skip: 'Currently broken' do
    it 'runs successfully' do
      pp = <<-PP
      class { 'openondemand':
        repo_nightly            => true,
        ondemand_package_ensure => 'latest',
        generator_insecure      => true,
      }
      PP

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
