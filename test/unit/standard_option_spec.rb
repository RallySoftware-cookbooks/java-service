require_relative '../../libraries/standard_option'

describe StandardOption do
  let(:name) { "ea" }
  let(:value) { "com.wombat.fruitbat" }
  subject { StandardOption.new(name, value) }

  describe "#to_s" do
    its(:to_s) { should == "-ea:com.wombat.fruitbat" }

    context "when the value is nil" do
      let(:name) { "server" }
      let(:value) { nil }
      its(:to_s) { should == "-server" }
    end
  end
end
