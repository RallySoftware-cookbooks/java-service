actions :create
default_action :create

attribute :service_name, :kind_of => String, :name_attribute => true
attribute :main_class, :kind_of => String
attribute :classpath, :kind_of => String
attribute :args, :kind_of => String
attribute :user, :kind_of => String
