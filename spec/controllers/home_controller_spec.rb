require 'spec_helper'

describe HomeController do
  let(:submission) { mock_model(Submission, save: true, :user= => true) }
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SubmissionsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET 'index'" do
    it "assigns all submissions as @submissions" do
      Submission.stub(:accessible_by).and_return([submission])
      Submission.should_receive(:accessible_by)
      get :index, {}, valid_session
      assigns(:submissions).should eq([submission])
    end
  end
end
