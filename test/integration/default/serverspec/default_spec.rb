require_relative 'spec_helper'

describe 'java_service_test::default' do
  describe port(9999) do
    it { should be_listening }
  end
end