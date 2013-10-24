require_relative '../../libraries/java_command'


describe JavaCommand do
  context "when created with the name of a class" do
    let(:options) { Hash.new }
    let(:class_or_jar) { 'SomeClass' }
    subject { JavaCommand.new(class_or_jar, options)}

    its(:to_s) { should == 'java SomeClass' }

    context "when created with a classpath" do
      let(:classpath) { 'some/path:some/different/path' }
      let(:options) { { :classpath => classpath } }

      its(:to_s) { should == "java -classpath #{classpath} SomeClass" }
    end

    context "when created with options" do
      let(:options) { {
        :system_properties => {'foo' => 'bar' },
        :standard_options => { 'server' => nil },
        :non_standard_options => { 'ms' => '69m' },
        :hotspot_options => { 'PrintCompilation' => true },
        :args => ['balls', 'droopy']
      }}
      its(:to_s) { should == 'java -Dfoo=bar -server -Xms69m -XX:+PrintCompilation SomeClass balls droopy' }
    end
  end

  context "when created with the path to a jar file" do
    let(:options) { Hash.new }
    let(:class_or_jar) { '/path/application.jar' }
    subject { JavaCommand.new(class_or_jar, options)}

    its(:to_s) { should == 'java -jar /path/application.jar' }

    context "when created with options" do
      let(:options) { {
        :system_properties => {'foo' => 'bar' },
        :standard_options => { 'server' => nil },
        :non_standard_options => { 'ms' => '69m' },
        :hotspot_options => { 'PrintCompilation' => true },
        :args => ['balls', 'droopy']

      }}
      its(:to_s) { should == 'java -Dfoo=bar -server -Xms69m -XX:+PrintCompilation -jar /path/application.jar balls droopy' }
    end
  end
end