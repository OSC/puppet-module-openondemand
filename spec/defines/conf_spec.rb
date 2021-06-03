require 'spec_helper'

describe 'openondemand::conf' do
  on_supported_os(supported_os: [{ 'operatingsystem' => 'RedHat', 'operatingsystemrelease' => ['8'] }]).each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let :title do
        'test'
      end

      let :params do
        { data: { 'foo' => 'bar' } }
      end

      it do
        is_expected.to contain_file('/etc/ood/config/ondemand.d/test.yml').with(
          ensure: 'file',
          owner: 'root',
          group: 'root',
          mode: '0644',
          source: nil,
          notify: 'Class[Openondemand::Service]',
        )
      end

      it 'has valid config' do
        content = catalogue.resource('file', '/etc/ood/config/ondemand.d/test.yml').send(:parameters)[:content]
        data = YAML.safe_load(content)
        expect(data).to eq(params[:data])
      end

      context 'when source defined' do
        let(:params) { { source: 'foobar' } }

        it do
          is_expected.to contain_file('/etc/ood/config/ondemand.d/test.yml').with(
            ensure: 'file',
            owner: 'root',
            group: 'root',
            mode: '0644',
            content: nil,
            source: 'foobar',
            notify: 'Class[Openondemand::Service]',
          )
        end
      end

      context 'when content defined' do
        let(:params) { { content: 'foobaz' } }

        it do
          is_expected.to contain_file('/etc/ood/config/ondemand.d/test.yml').with(
            ensure: 'file',
            owner: 'root',
            group: 'root',
            mode: '0644',
            content: 'foobaz',
            source: nil,
            notify: 'Class[Openondemand::Service]',
          )
        end
      end

      context 'when template is true' do
        let(:params) { { template: true, data: { 'foo' => 'bar' } } }

        it { is_expected.to contain_file('/etc/ood/config/ondemand.d/test.yml.erb') }
      end

      context 'when filename is defined' do
        let(:params) { { filename: 'foo.yml', data: { 'foo' => 'bar' } } }

        it { is_expected.to contain_file('/etc/ood/config/ondemand.d/foo.yml') }
      end
    end
  end
end
