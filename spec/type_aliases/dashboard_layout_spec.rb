require 'spec_helper'

describe 'Openondemand::Dashboard_layout' do
  describe 'allow valid values' do
    it 'accepts dashboard layout' do
      value = {
        'rows' => [
          {
            'columns' => [
              { 'width' => 8, 'widgets' => ['pinned_apps', 'motd'] },
              { 'width' => 4, 'widgets' => ['xdmod_widget_job_efficiency', 'xdmod_widget_jobs'] },
            ],
          },
        ],
      }
      is_expected.to allow_value(value)
    end
  end
end
