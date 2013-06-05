require 'submissions'
require 'submissions/presenters/instance'

describe Pf::Submissions do
  describe ".present" do
    it "fetchs a presenter given an ID" do
      submission = double
      presenter = double
      allow(Pf::Submissions::Presenters::Instance).to receive(:for).and_return(presenter)
      expect(Pf::Submissions.present(submission)).to eq(presenter)
    end
  end
end


