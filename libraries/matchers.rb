if defined?(ChefSpec)
  ChefSpec::Runner.define_runner_method(:java_service)

  def create_java_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:java_service, :create, resource_name)
  end

  def start_java_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:java_service, :start, resource_name)
  end

  def stop_java_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:java_service, :stop, resource_name)
  end

  def enable_java_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:java_service, :enable, resource_name)
  end

  def disable_java_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:java_service, :disable, resource_name)
  end

  def load_java_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:java_service, :load, resource_name)
  end

  def restart_java_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:java_service, :restart, resource_name)
  end

  def reload_java_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:java_service, :reload, resource_name)
  end
end
