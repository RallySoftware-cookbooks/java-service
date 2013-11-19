chef_api :config
site :opscode

metadata

cookbook 'bluepill', github: 'RallySoftware-cookbooks/bluepill'

group :test do
  cookbook 'java_service_test', :path => './test/cookbooks/java_service_test'
end
