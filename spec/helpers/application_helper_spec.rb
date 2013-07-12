require 'submissions'
require 'reviews'

describe ApplicationHelper do
  let(:presentee) do
    class Presentee

    end
    Presentee.new
  end
  let(:presenter) { double }

  describe "#present" do
    before(:each) do
      receiver = "Pf::#{presentee.class.to_s}s"
      stub_const(receiver, double(present: presenter))
    end
    it "takes an object and wraps it in a presenter class" do
      expect(present(presentee)).to eq(presenter)
    end

    it "takes and object and a block and yields the presenter" do
      expect { |b| present(presentee, &b) }.to yield_with_args(presenter)
    end
  end
end
