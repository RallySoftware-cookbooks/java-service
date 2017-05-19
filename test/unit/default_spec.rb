require_relative 'spec_helper'

describe 'java_service::default' do
  subject { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8', log_level: :error).converge described_recipe }

  it { should include_recipe 'java' }
  it { should include_recipe 'rs_bluepill' }
end
