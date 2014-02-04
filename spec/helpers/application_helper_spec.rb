require 'spec_helper'

describe ApplicationHelper do
  let(:submission) { FactoryGirl.build(:submission) }
  let(:presenter) { double }
  
  describe "#present" do
    it "takes an object and wraps it in a presenter class" do
      allow(Pf::Submissions::Presenters::Instance).to receive(:for).with(submission) { presenter }
      expect(present(submission)).to eq(presenter)
    end

    it "takes and object and a block and yields the presenter" do
      allow(Pf::Submissions::Presenters::Instance).to receive(:for).with(submission) { presenter }
      expect { |b| present(submission, &b) }.to yield_with_args(presenter)
    end
  end
end
