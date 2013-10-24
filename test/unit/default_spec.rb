require_relative 'spec_helper'

describe 'java_service_test::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new(:step_into => ['java-service']).converge 'java_service_test::default' }

  subject { chef_run }

  it { should include_recipe 'java' }

  it { should include_recipe 'bluepill' }

  context 'service template' do
    subject { chef_run.template('/etc/bluepill/echoserver.pill').variables }

    its(:name) { should eql 'echoserver' }
    its(:main_class) { should eql 'EchoServer' }
    its(:classpath) { should eql '/root/server.jar' }
    its(:system_properties) { should eql '-Dfooproperty=foovalue -Dbarproperty=barvalue ' }    
    its(:jvm_options) { should eql '-Xmx512m -Xms256m -XX:+UseConcMarkSweepGC ' }
    its(:user) { should eql 'root' }
  end

end
