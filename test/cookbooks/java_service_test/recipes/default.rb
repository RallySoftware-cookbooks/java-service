include_recipe 'java-service'

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
  main_class 'EchoServer'
  classpath '/root/server.jar'
  user 'root'
end

java_service 'echoserver2' do
  jar '/root/server.jar'
  user 'root'
  working_dir '/root'
end