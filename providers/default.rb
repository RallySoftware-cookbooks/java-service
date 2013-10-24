use_inline_resources

action :create do
  validate_input(new_resource)
  include_dependent_recipes(run_context)
  define_service(node, new_resource)
end

private

def include_dependent_recipes(run_context)
  run_context.include_recipe 'java'
  run_context.include_recipe 'bluepill'  
end

def validate_input(new_resource)
  required_attrs = [:main_class, :classpath, :service_name, :user]
  required_attrs.each { |attr|
    attr_value = new_resource.send(attr)
    raise "#{attr} must be defined when using the java_service provider." if attr_value.nil?
  }
end

def define_service(node, new_resource)
  props = system_properties(node, new_resource)
  opts = jvm_options(node, new_resource)

  template "#{node[:bluepill][:conf_dir]}/#{new_resource.service_name}.pill" do
    source 'service.pill.erb'
    cookbook 'java-service'
    variables ({
      :name => new_resource.service_name,
      :classpath => new_resource.classpath,
      :system_properties => props,
      :jvm_options => opts,
      :main_class => new_resource.main_class,
      :user => new_resource.user,
      :args => new_resource.args
    })
  end

  bluepill_service new_resource.service_name do
    action [:enable, :load, :start]
  end
end

def system_properties(node, new_resource)
  dash_d_params = ''
  node[new_resource.name]['D'].each do |key, value|
    dash_d_params.concat("-D#{key}#{build_value(value)}").concat(" ")
  end
  dash_d_params
end

def jvm_options(node, new_resource)
  jvm_options = ''
  node[new_resource.service_name]['jvm_options'].each do |key, value|
    jvm_options.concat("-#{key}#{build_value(value)}").concat(" ")
  end
  jvm_options
end

def build_value(value)
  if value.nil?
    value = ''
  else
    value = "=#{value}"
  end
  value
end

  