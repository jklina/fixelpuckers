require 'submissions'
require 'submissions/presenters/instance'

describe Pf::Submissions do
  describe ".present" do
    it "fetchs a presenter given an ID" do
      submission = stub
      presenter = stub
      Pf::Submissions::Presenters::Instance.stub(:for).and_return(presenter)
      expect(Pf::Submissions.present(submission)).to eq(presenter)
    end
  end
end


