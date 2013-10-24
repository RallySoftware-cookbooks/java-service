require_relative 'option'

class NonStandardOption < Option
  def initialize(name, value)
    super(name, value, '-X', proc { |option_name| option_name =~ /^(ms|mx|ss)$/ ? '' : ':' })
  end
end