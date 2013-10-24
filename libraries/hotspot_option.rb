require_relative 'option'

class HotspotOption < Option
  def initialize(name, value)
    if value == true
      name = name.prepend('+')
      value = nil
    elsif value == false
      name = name.prepend('-')
      value = nil
    end

    super(name, value, '-XX:', '=')
  end
end