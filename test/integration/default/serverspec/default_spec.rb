require_relative 'spec_helper'

describe 'java_service_test::default' do
  describe service('bluepilld: echoserver') do
    it { should be_running }
  end

  describe port(9999) do
    it { should be_listening }
  end

  describe service('bluepilld: echoserver2') do
    it { should be_running }
  end

  describe port(9989) do
    it { should be_listening }
  end

  describe file('/root/echoserver.pill') do
    it { should be_file }
  end
end
