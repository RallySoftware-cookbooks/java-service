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

  describe port(9002) do
    it { should be_listening }
  end

  describe file('/root/echoserver.pill') do
    it { should be_file }
  end

  describe file('/root/theoutput.log') do
    it { should be_file }
  end

  describe file('/root/theoutput.log.1.gz') do
    it { should be_file }
  end

  describe file('/root/theoutput.log.2.gz') do
    it { should be_file }
  end

  describe command('/opt/chef/embedded/bin/bluepill echoserver status') do
    it { should return_stdout /up/ }
    it { should_not return_stdout /unmonitored/ }
  end
end
