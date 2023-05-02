# frozen_string_literal: true

require 'spec_helper'

describe 'openondemand' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

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
