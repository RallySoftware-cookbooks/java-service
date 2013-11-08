class JavaCommand
  def initialize(class_or_jar, options = {})
    if class_or_jar.end_with?('.jar')
      @jar = class_or_jar
    else
      @class_name = class_or_jar
    end

    @classpath            = options[:classpath]
    @system_properties    = map_options(options[:system_properties], SystemProperty)
    @standard_options     = map_options(options[:standard_options], StandardOption)
    @non_standard_options = map_options(options[:non_standard_options], NonStandardOption)
    @hotspot_options      = map_options(options[:hotspot_options], HotspotOption)
    @args                 = options[:args] || []
  end

  def to_s
    generate_command
  end

  private

  attr_reader :jar
  attr_reader :class_name
  attr_reader :classpath
  attr_reader :system_properties
  attr_reader :standard_options
  attr_reader :non_standard_options
  attr_reader :hotspot_options
  attr_reader :args

  def map_options(options, klass)
    options = {} unless options
    options.map { |name, value| klass.new(name.to_s.dup, value) }
  end

  def generate_command
    command = ['java']

    (command << '-classpath' << classpath) if classpath

    command << system_properties
    command << standard_options
    command << non_standard_options
    command << hotspot_options

    if jar
      command << '-jar' << jar
    else
      command << class_name
    end

    command << args
    command.flatten.join(' ')
  end
end

def rotate_log_file(log_file_path=nil)
  return if log_file_path.nil?

  log_file_path = File.expand_path log_file_path
  if File.exist? log_file_path
    LogRotate.rotate_file(log_file_path, :count => 5, :gzip => true)
  else
    FileUtils.mkdir_p(File.dirname(log_file_path))
  end
end
