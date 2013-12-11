require_relative 'spec_helper'

describe 'java_service_test::default' do
  subject { ChefSpec::Runner.new(step_into: ['java_service'], log_level: :error).converge described_recipe }

  it { should render_file('/root/echoserver.pill').with_content(echoserver_pill_file_content) }
  it { should render_file('/etc/bluepill/echoserver2.pill').with_content(echoserver2_pill_file_content) }
  it { should render_file('/etc/bluepill/echoserver3.pill').with_content(echoserver3_pill_file_content) }
  it { should render_file('/etc/bluepill/nooptionsorargs.pill').with_content(nooptionsorargs_pill_file_content) }

end

def echoserver_pill_file_content
  <<-PILL.strip
# -*- mode: ruby -*-
Bluepill.application("echoserver") do |app|
  app.process("echoserver") do |process|
    process.working_dir = "."
    process.start_command = "java -classpath /root/server.jar -Dport=9999 -server -Xms256m -XX:+UseConcMarkSweepGC EchoServer foo bar"
    process.pid_file = "/tmp/echoserver.pid"
    process.stdout = process.stderr = "/root/theoutput.log"
    process.uid = "root"
    process.gid = "root"
    process.daemonize = true
  end
end
PILL
end

def echoserver2_pill_file_content
  <<-PILL.strip
# -*- mode: ruby -*-
Bluepill.application("echoserver2") do |app|
  app.process("echoserver2") do |process|
    process.working_dir = "/root"
    process.start_command = "java -classpath late:bound:string -Dport=9989 -server -Xms256m -XX:+UseConcMarkSweepGC -jar /root/server.jar foo bar"
    process.pid_file = "/tmp/echoserver2.pid"
    process.uid = "root"
    process.gid = "root"
    process.daemonize = true
  end
end
PILL
end

def echoserver3_pill_file_content
  <<-PILL.strip
# -*- mode: ruby -*-
Bluepill.application("echoserver3") do |app|
  app.process("echoserver3") do |process|
    process.working_dir = "/root"
    process.start_command = "java -classpath an:array:of:paths -jar /root/server.jar"
    process.pid_file = "/tmp/echoserver3.pid"
    process.uid = "root"
    process.gid = "root"
    process.daemonize = true
  end
end
PILL
end

def nooptionsorargs_pill_file_content
  <<-PILL.strip
# -*- mode: ruby -*-
Bluepill.application("nooptionsorargs") do |app|
  app.process("nooptionsorargs") do |process|
    process.working_dir = "."
    process.start_command = "java -jar /root/server.jar"
    process.pid_file = "/tmp/nooptionsorargs.pid"
    process.uid = "root"
    process.gid = "root"
    process.daemonize = true
  end
end
PILL
end
