require_relative '../../libraries/non_standard_option'

describe NonStandardOption do
  let(:name) { "bootclasspath" }
  let(:value) { "/some/path" }
  subject { NonStandardOption.new(name, value) }

  describe "#to_s" do
    its(:to_s) { should == "-Xbootclasspath:/some/path" }

    context "when the value is nil" do
      let(:name) { "int" }
      let(:value) { nil }
      its(:to_s) { should == "-Xint" }
    end

    context "when the option name is ms" do
      let(:name) { "ms" }
      let(:value) { "69m" }
      its(:to_s) { should == "-Xms69m" }
    end

    context "when the option name is mx" do
      let(:name) { "mx" }
      let(:value) { "69m" }
      its(:to_s) { should == "-Xmx69m" }
    end

    context "when the option name is ss" do
      let(:name) { "ss" }
      let(:value) { "69m" }
      its(:to_s) { should == "-Xss69m" }
    end
  end
end
