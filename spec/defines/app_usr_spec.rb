require 'spec_helper'

describe 'openondemand::app::usr' do
  on_supported_os(supported_os: [{ 'operatingsystem' => 'RedHat', 'operatingsystemrelease' => ['8'] }]).each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let :title do
        'test'
      end

      let :params do
        { gateway_src: '/home/test/ondemand' }
      end

      it do
        is_expected.to contain_file('/var/www/ood/apps/usr/test').with('ensure' => 'directory',
                                                                       'owner'   => 'root',
                                                                       'group'   => 'root',
                                                                       'mode'    => '0750')
      end
    end
  end
end
