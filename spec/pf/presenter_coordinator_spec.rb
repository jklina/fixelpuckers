require 'presenter_coordinator'
require 'submissions'
require 'submissions/presenters/instance'
require 'users'
require 'users/presenters/instance'

describe Pf::PresenterCoordinator do
  describe ".present" do
    it "fetchs a submission presenter given a submission ID" do
      class Submission; end;
      submission = Submission.new
      presenter = double
      allow(Pf::Submissions::Presenters::Instance).to receive(:for).and_return(presenter)
      expect(Pf::PresenterCoordinator.present(submission)).to eq(presenter)
    end

    it "fetchs a user presenter given a user ID" do
      class User; end;
      user = User.new
      presenter = double
      allow(Pf::Users::Presenters::Instance).to receive(:for).and_return(presenter)
      expect(Pf::PresenterCoordinator.present(user)).to eq(presenter)
    end
  end
end


