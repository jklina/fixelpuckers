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

  describe "#admin?" do
    it "returns true when the current controller is in the admin namespace" do
      controller.stub_chain(:class, :name).and_return("Admin::Test")
      expect(admin?).to be_true
    end

    it "returns true when the current controller is admin" do
      controller.stub_chain(:class, :name).and_return("AdminController")
      expect(admin?).to be_true
    end

    it "returns false when the controller isn't in the admin namespace" do
      controller.stub_chain(:class, :name).and_return("Test")
      expect(admin?).to be_false
    end
  end
end
