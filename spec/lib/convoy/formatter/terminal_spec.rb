describe Convoy::Formatter::Terminal do
    let(:terminal) { Convoy::Formatter::Terminal }

    describe "#width" do
        subject { terminal.width }

        context "when width can be found successfully" do
            let(:current_width) { `/usr/bin/env tput cols`.to_i }
            it("should be equal to current width") { subject.should == current_width }
        end

        context "when width could not be found successfully" do
            before do
                Convoy::Formatter::ShellCommandExecutor.any_instance.stub(:execute_in_current_shell).and_return(nil)
            end
            it("should be equal to default width") { subject.should == Convoy::Formatter::Terminal::DEFAULT_WIDTH }
        end
    end
end
