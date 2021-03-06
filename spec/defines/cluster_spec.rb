require 'spec_helper'

describe 'openondemand::cluster' do
  on_supported_os(supported_os: [{ 'operatingsystem' => 'RedHat', 'operatingsystemrelease' => ['8'] }]).each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let :title do
        'test'
      end

      let :default_params do
        {
          acls: [
            {
              'adapter' => 'group',
              'groups' => ['test-group'],
              'type' => 'whitelist',
            },
          ],
          rsv_query_acls: [
            {
              'adapter' => 'group',
              'groups' => ['test-group-rsv'],
              'type' => 'blacklist',
            },
          ],
          login_host: 'login.test',
          job_adapter: 'torque',
          job_host: 'batch.test',
          job_lib: '/opt/torque/lib64',
          job_bin: '/opt/torque/bin',
          job_version: '6.0.2',
          scheduler_type: 'moab',
          scheduler_host: 'batch.test',
          scheduler_bin: '/opt/moab/bin',
          scheduler_version: '9.0.1',
          scheduler_params: {
            'moabhomedir' => '/var/spool/moab',
          },
          ganglia_host: 'ganglia.test',
          batch_connect: {
            'basic' => { 'script_wrapper' => 'module restore\n%s' },
            'vnc'   => { 'script_wrapper' => 'module restore\nmodule load ondemand-vnc\n%s' },
          },
        }
      end

      let(:params) { default_params }

      it do
        is_expected.to contain_file('/etc/ood/config/clusters.d/test.yml').with('ensure' => 'file',
                                                                                'owner'   => 'root',
                                                                                'group'   => 'root',
                                                                                'mode'    => '0644')
      end

      it do
        content = catalogue.resource('file', '/etc/ood/config/clusters.d/test.yml').send(:parameters)[:content]
        puts content
      end

      context 'kubernetes' do
        let :params do
          {
            job_adapter: 'kubernetes',
            job_cluster: 'k8-dev',
            job_bin: '/usr/bin/kubectl',
            job_username_prefix: 'dev',
            job_server: { 'endpoint' => 'https://k8dev.example.com:6443', 'cert_authority_file' => '/etc/k8dev.crt' },
            job_mounts: [
              { 'name' => 'home', 'destination_path' => '/home', 'path' => '/home', 'host_type' => 'Directory', 'type' => 'host' },
            ],
            job_auth: { 'type' => 'oidc' },
            batch_connect: { 'ssh_allow' => false },
          }
        end

        it { is_expected.to compile.with_all_deps }

        it do
          content = catalogue.resource('file', '/etc/ood/config/clusters.d/test.yml').send(:parameters)[:content]
          puts content
          data = YAML.safe_load(content)
          expect(data['v2']['job']['bin']).to eq('/usr/bin/kubectl')
        end
      end

      context 'with grafana defined' do
        let :params do
          default_params.merge!(
            ganglia_host: nil,
            grafana_host: 'https://grafana.domain',
            grafana_dashboard_name: 'test',
            grafana_dashboard_uid: 'foo',
            grafana_dashboard_panels: { 'cpu' => 1, 'memory' => 2 },
            grafana_labels: { 'cluster' => 'cluster', 'host' => 'host' },
          )
        end

        it { is_expected.to compile.with_all_deps }

        context 'with slurm' do
          let :params do
            {
              job_adapter: 'slurm',
              job_host: 'pitzer-slurm01.ten.osc.edu',
              job_cluster: 'pitzer',
              job_bin: '/usr/bin',
              job_lib: '/usr/lib64',
              job_conf: '/etc/slurm/slurm.conf',
              grafana_host: 'https://grafana.domain',
              grafana_dashboard_name: 'test',
              grafana_dashboard_uid: 'foo',
              grafana_dashboard_panels: { 'cpu' => 1, 'memory' => 2 },
              grafana_labels: { 'cluster' => 'cluster', 'host' => 'host' },
            }
          end

          it { is_expected.to compile.with_all_deps }

          it do
            content = catalogue.resource('file', '/etc/ood/config/clusters.d/test.yml').send(:parameters)[:content]
            data = YAML.safe_load(content)
            expect(data['v2']['custom']['grafana']['host']).to eq('https://grafana.domain')
          end
        end

        context 'with partial params' do
          let :params do
            default_params.merge!(
              ganglia_host: nil,
              grafana_host: 'https://grafana.domain',
            )
          end

          it 'fails with lack of parameters' do
            is_expected.to compile.and_raise_error(%r{Must define grafana})
          end
        end

        context 'require cpu and memory panels' do
          let :params do
            default_params.merge!(
              ganglia_host: nil,
              grafana_host: 'https://grafana.domain',
              grafana_dashboard_name: 'test',
              grafana_dashboard_uid: 'foo',
              grafana_dashboard_panels: { 'cpu' => 1 },
              grafana_labels: { 'cluster' => 'cluster', 'host' => 'host' },
            )
          end

          it 'fails' do
            is_expected.to compile.and_raise_error(%r{expects a value for key 'memory'})
          end
        end
      end
    end
  end
end
