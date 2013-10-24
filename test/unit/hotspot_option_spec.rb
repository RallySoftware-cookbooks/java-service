require_relative '../../libraries/option'
require_relative '../../libraries/hotspot_option'

describe HotspotOption do
  let(:name) { "FlightRecorder" }
  let(:value) { true }
  subject { HotspotOption.new(name, value) }

  describe "#to_s" do
    its(:to_s) { should == "-XX:+FlightRecorder" }

    context "when the value is false" do
      let(:value) { false }
      its(:to_s) { should == "-XX:-FlightRecorder" }
    end

    context "when the value is not true or false" do
      let(:name) { "LargePageSizeInBytes" }
      let(:value) { "69m" }
      its(:to_s) { should == "-XX:LargePageSizeInBytes=69m" }
    end
  end
end
