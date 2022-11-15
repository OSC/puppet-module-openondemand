# frozen_string_literal: true

shared_examples 'openondemand::apache' do |_facts|
  it do
    content = catalogue.resource('file', '/etc/ood/config/ood_portal.yml').send(:parameters)[:content]
    puts content
  end
end
