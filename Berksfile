chef_api :config
site :opscode

metadata

cookbook 'bluepill', github: 'RallySoftware-cookbooks/bluepill', ref: '99d36011e49bd6b2f79c090ef9a88f6533b71453'

group :test do
  cookbook 'java_service_test', :path => './test/cookbooks/java_service_test'
end
