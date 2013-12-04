require_relative 'spec_helper'

describe 'java_service::default' do
  subject { ChefSpec::Runner.new(log_level: :error).converge described_recipe }

  it { should include_recipe 'java' }
  it { should include_recipe 'bluepill' }
end
