require 'submissions'

describe ApplicationHelper do
  let(:submission) { FactoryGirl.build(:submission) }
  let(:presenter) { stub() }
  
  describe "#present" do
    it "takes an object and wraps it in a presenter class" do
      Pf::Submissions::Presenters::Instance.stub(:for).with(submission) { presenter }
      expect(present(submission)).to eq(presenter)
    end

    it "takes and object and a block and yields the presenter" do
      Pf::Submissions::Presenters::Instance.stub(:for).with(submission) { presenter }
      expect { |b| present(submission, &b) }.to yield_with_args(presenter)
    end
  end
end
