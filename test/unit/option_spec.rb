require_relative '../../libraries/option'

describe Option do
  let(:name) { "foo" }
  let(:value) { "bar" }
  let(:prefix) { "-T" }
  let(:separator) { "=>" }

  subject { Option.new(name, value, prefix, separator) }

  describe "#to_s" do
    context "when created with a name, value, prefix and a separator as a String" do
      its(:to_s) { should == '-Tfoo=>bar'}
    end

    context "when created with a name, value, prefix and a separator as a block" do
      let(:name) { "ms" }
      let(:value) { "512m" }
      let(:prefix) { "-X" }
      let(:separator) { proc { |option_name| option_name =~ /^(ms|mx|ss)$/ ? '' : ':' } }
      its(:to_s) { should == '-Xms512m' }
    end

    context "when created with a name and a nil value" do
      let(:value) { nil }
      its(:to_s) { should == '-Tfoo'}
    end

    context "when the value has spaces in it" do
      let(:value) { "bar baz" }
      its(:to_s) { should == '-Tfoo=>"bar baz"'}
    end

    context "when the value has spaces in it but is already surrounded by double quotes" do
      let(:value) { "\"bar baz\"" }
      its(:to_s) { should == '-Tfoo=>"bar baz"'}
    end

    context "when the value has spaces in it but is already surrounded by single quotes" do
      let(:value) { "'bar baz'" }
      its(:to_s) { should == '-Tfoo=>\'bar baz\'' } 
    end
  end
end
