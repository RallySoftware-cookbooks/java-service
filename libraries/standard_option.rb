require_relative 'option'

class StandardOption < Option
  def initialize(name, value)
    super(name, value, '-', ':')
  end
end