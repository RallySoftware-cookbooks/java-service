include_recipe 'java_service'

template '/root/EchoServer.java' do
  source 'EchoServer.java.erb'
end

execute 'javac EchoServer.java' do
  cwd '/root'
end

file '/root/manifest.txt' do
  content "Main-Class: EchoServer\n"
end

execute 'jar cvfm server.jar manifest.txt EchoServer.class' do
  cwd '/root'
end

java_service 'echoserver' do
  action [:create, :enable, :load]
  main_class 'EchoServer'
  classpath '/root/server.jar'
  user 'root'
  pill_file_dir '/root'
  log_file '/root/theoutput.log'
end

java_service 'echoserver2' do
  action [:create, :enable, :load]
  jar '/root/server.jar'
  user 'root'
  working_dir '/root'
  classpath Proc.new{ "late:bound:string" }
end

java_service 'echoserver3' do
  action [:create, :enable, :load]
  jar '/root/server.jar'
  user 'root'
  working_dir '/root'
  classpath ["an", "array", "of", "paths"]
  system_properties "port" => "9001"
end

java_service 'echoserver4' do
  action [:create, :enable, :load, :start]
  main_class 'EchoServer'
  classpath '/root/server.jar'
  user 'root'
  log_file '/root/echoserver4.log'
  system_properties({port: "9002", timer: "2000"})
  start_retries 3
  start_delay   1
  start_check Proc.new {
    Mixlib::ShellOut.new("netstat -tunl | grep -- 9002").run_command.stdout =~ /LISTEN/
  }
end

java_service 'nooptionsorargs' do
  action [:create, :enable, :load]
  jar '/root/server.jar'
  user 'root'
end

java_service 'echoserver' do
  action :restart
  pill_file_dir '/root'
end

java_service 'echoserver' do
  action :stop
  pill_file_dir '/root'
end

java_service 'echoserver' do
  action :start
  pill_file_dir '/root'
end
