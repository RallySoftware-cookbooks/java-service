require_relative 'option'

class SystemProperty < Option
  def initialize(name, value)
    super(name, value, '-D', '=')
  end
end