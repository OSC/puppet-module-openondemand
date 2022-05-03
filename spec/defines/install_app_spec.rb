require 'spec_helper'

describe 'openondemand::install::app' do
  on_supported_os(supported_os: [{ 'operatingsystem' => 'RedHat', 'operatingsystemrelease' => ['8'] }]).each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let :title do
        'test'
      end

      let :params do
        {}
      end

      it do
        is_expected.to contain_package('ondemand-test').with(
          'ensure'  => 'present',
          'require' => 'Package[ondemand]',
        )
      end

      it do
        is_expected.to contain_file('/var/www/ood/apps/sys/test').with(
          'ensure' => 'directory',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0755',
        )
      end

      context 'when git repo' do
        let :params do
          {
            'git_repo' => 'https://github.com/foo/test',
          }
        end

        it { is_expected.not_to contain_package('ondemand-test') }
        it do
          is_expected.to contain_vcsrepo('/var/www/ood/apps/sys/test').with(
            'ensure'    => 'present',
            'source'    => 'https://github.com/foo/test',
            'revision'  => nil,
            'provider'  => 'git',
            'require'   => 'Package[ondemand]',
          )
        end
        it { is_expected.to contain_vcsrepo('/var/www/ood/apps/sys/test').that_comes_before('File[/var/www/ood/apps/sys/test]') }
      end
    end
  end
end
