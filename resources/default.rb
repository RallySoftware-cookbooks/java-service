actions :create, :start, :stop, :enable, :disable, :load, :restart, :reload
default_action :create

attribute :service_name, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String, :required => true
attribute :main_class, :kind_of => String
attribute :jar, :kind_of => String
attribute :classpath, :kind_of => [String, Proc]
attribute :working_dir, :kind_of => String, :default => '.'
attribute :system_properties, :kind_of => Hash
attribute :standard_options, :kind_of => Hash
attribute :non_standard_options, :kind_of => Hash
attribute :hotspot_options, :kind_of => Hash
attribute :args, :kind_of => Array
attribute :pill_file_dir, :kind_of => String
