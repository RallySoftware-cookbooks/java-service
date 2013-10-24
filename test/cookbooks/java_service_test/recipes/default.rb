include_recipe 'java'

template '/root/EchoServer.java' do
  source 'EchoServer.java.erb'  
end

execute 'javac EchoServer.java' do
  cwd '/root'
end

execute 'jar cvf server.jar EchoServer.class' do
  cwd '/root'
end

java_service 'echoserver' do
  main_class 'EchoServer'
  classpath '/root/server.jar'
  user 'root'
end
