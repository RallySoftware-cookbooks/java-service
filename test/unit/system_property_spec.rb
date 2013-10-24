require_relative '../../libraries/system_property'

describe SystemProperty do
  let(:name) { "foo" }
  let(:value) { "bar" }
  subject { SystemProperty.new(name, value) }

  describe "#to_s" do
    its(:to_s) { should == "-Dfoo=bar" }

    context "when the value is nil" do
      let(:value) { nil }
      its(:to_s) { should == "-Dfoo" }
    end
  end
end
