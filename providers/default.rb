use_inline_resources

action :create do
  if new_resource.main_class && new_resource.jar
    raise 'You can specify a main_class or a jar file but not both.'
  end

  unless new_resource.main_class || new_resource.jar
    raise 'You must specify main_class or jar'
  end

  pill_file_dir = new_resource.pill_file_dir || node['bluepill']['conf_dir']

  template "#{pill_file_dir}/#{new_resource.service_name}.pill" do
    source 'service.pill.erb'
    cookbook 'java-service'
    variables ({
      :name => new_resource.service_name,
      :java_command => java_command,
      :user => new_resource.user,
      :working_dir => new_resource.working_dir
    })
  end

  bluepill_service new_resource.service_name do
    action [:enable, :load, :start]
    conf_dir pill_file_dir
  end
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
