# frozen_string_literal: true

require 'spec_helper'

describe 'openondemand' do
  on_supported_os.each do |os, facts|
    context "when #{os}" do
      let(:facts) do
        facts
      end
      let(:default_params) do
        if facts[:os]['name'] == 'Ubuntu' && facts[:os]['release']['major'] == '20.04'
          { repo_release: '4.0' }
        else
          {}
        end
      end
      let(:param_override) { {} }
      let(:params) { default_params.merge(param_override) }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to create_class('openondemand') }

      case facts[:os]['family']
      when 'RedHat'
        include_context 'openondemand::repo::rpm', facts
      when 'Debian'
        include_context 'openondemand::repo::apt', facts
      end
      include_context 'openondemand::apache', facts
      include_context 'openondemand::config', facts

      it { is_expected.to contain_package('ondemand').that_comes_before('Class[sudo]') }
    end
  end
end
