use_inline_resources

action :create do
  if new_resource.main_class && new_resource.jar
    raise 'You can specify a main_class or a jar file but not both.'
  end

  unless new_resource.main_class || new_resource.jar
    raise 'You must specify main_class or jar'
  end

  template "#{pill_file_dir}/#{new_resource.service_name}.pill" do
    source 'service.pill.erb'
    cookbook 'java-service'
    variables ({
      :name => new_resource.service_name,
      :java_command => java_command,
      :user => new_resource.user,
      :log_file => new_resource.log_file,
      :working_dir => new_resource.working_dir
    })
  end
end

action :start do
  rotate_service_log
  delegate_action :start
end

action :stop do
  delegate_action :stop
end

action :enable do
  delegate_action :enable
end

action :disable do
  delegate_action :disable
end

action :load do
  delegate_action :load
end

action :restart do
  rotate_service_log
  delegate_action :restart
end

action :reload do
  delegate_action :reload
end

def rotate_service_log
  chef_gem 'logrotate' do
    action :install
  end

  require 'logrotate'

  ruby_block 'Rotating log file' do #~FC021
    block do
      LogRotate.rotate_file(new_resource.log_file, :count => 5, :gzip => true)
    end
    only_if { !new_resource.log_file.nil? && ::File.exist?(new_resource.log_file) && !::File.zero?(new_resource.log_file) }
  end
end

def delegate_action(action)
  bluepill_service new_resource.service_name do
    action action
    conf_dir pill_file_dir
  end
end

def pill_file_dir
  new_resource.pill_file_dir || node['bluepill']['conf_dir']
end

def java_command
  classpath = new_resource.classpath.is_a?(Proc) ? instance_eval(&new_resource.classpath) : new_resource.classpath
  system_properties = resource_or_node_value('system_properties', '-D')
  standard_options = resource_or_node_value('standard_options', '-')
  non_standard_options = resource_or_node_value('non_standard_options', '-X')
  hotspot_options = resource_or_node_value('hotspot_options', '-XX')
  args = resource_or_node_value('args', 'args', [])

  JavaCommand.new(new_resource.main_class || new_resource.jar, {
    :classpath => classpath,
    :system_properties => system_properties,
    :standard_options => standard_options,
    :non_standard_options => non_standard_options,
    :hotspot_options => hotspot_options,
    :args => args
  })
end

def resource_or_node_value(name, node_name, default_value = {})
  from_resource = new_resource.send(name)
  from_node = (node[new_resource.name] && node[new_resource.name]['java'] && node[new_resource.name]['java'][node_name]) || default_value
  return from_resource || from_node
end
