use_inline_resources

action :create do
  if new_resource.main_class && new_resource.jar 
    raise 'You can specify a main_class or a jar file but not both.'
  end

  unless new_resource.main_class || new_resource.jar
    raise 'You must specify main_class or jar'
  end

  template "#{node['bluepill']['conf_dir']}/#{new_resource.service_name}.pill" do
    source 'service.pill.erb'
    cookbook 'java-service'
    variables ({
      :name => new_resource.service_name,
      :java_command => java_command,
      :user => new_resource.user
    })
  end

  bluepill_service new_resource.service_name do
    action [:enable, :load, :start]
  end
end

def java_command

  system_properties = new_resource.system_properties || node[new_resource.name]['java']['-D']
  standard_options = new_resource.standard_options || node[new_resource.name]['java']['-']
  non_standard_options = new_resource.non_standard_options || node[new_resource.name]['java']['-X']
  hotspot_options = new_resource.hotspot_options || node[new_resource.name]['java']['-XX']
  args = new_resource.args || node[new_resource.name]['java']['args']

  JavaCommand.new(new_resource.main_class || new_resource.jar, {
    :classpath => new_resource.classpath,
    :system_properties => system_properties,
    :standard_options => standard_options,
    :non_standard_options => non_standard_options,
    :hotspot_options => hotspot_options,
    :args => args
  })
end