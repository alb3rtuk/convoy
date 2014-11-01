describe Convoy::Setup::Configuration::Locator::ExecutingScriptDirectory do
  include FakeFS::SpecHelpers

  let(:locator) {Convoy::Setup::Configuration::Locator::ExecutingScriptDirectory.new(filename)}
  let(:filename) {'.blahrc'}
  let(:directory) {File.expand_path(File.dirname($0))}
  let(:path) {File.join(directory, filename)}

  describe "#locate" do
    subject {locator.locate}

    context "when file does not exist in directory" do
      before do
        FileUtils.mkdir_p(directory)
      end

      it {subject.should be_nil}
    end

    context "when file exists in directory" do
      before do
        FileUtils.mkdir_p(directory)
        File.open(path, 'w') {|f| f.write("hello") }
      end

      it {subject.should == path}
    end
  end
end
