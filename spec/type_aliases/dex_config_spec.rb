# frozen_string_literal: true

require 'spec_helper'

describe 'Openondemand::Dex_config' do
  describe 'allow valid values' do
    it { is_expected.to allow_value({}) }

    it 'accepts LDAP connectors' do
      value = {
        'connectors' => [{
          'type' => 'ldap',
          'id' => 'ldap',
          'config' => {
            'host' => 'ldap.example.org',
          },
        }],
      }
      is_expected.to allow_value(value)
    end
  end
end
