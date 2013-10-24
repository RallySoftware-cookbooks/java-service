class Option
  attr_reader :name
  attr_reader :value
  attr_reader :prefix

  def initialize(name, value, prefix, separator)
    @name = name
    @value = value
    @prefix = prefix
    @separator = separator
  end

  def apply_quotes(value)
    if /\s/ =~ value.to_s and not /^(["']).*\1$/ =~ value
      value = "\"#{value}\""
    end
    value
  end

  def to_s
    if value
      "#{prefix}#{name}#{separator}#{apply_quotes(value)}" 
    else
      "#{prefix}#{name}"
    end
  end

  def separator
    if @separator.kind_of? Proc
      @separator.call(@name)
    else
      @separator
    end
  end
end