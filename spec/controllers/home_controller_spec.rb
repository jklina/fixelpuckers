require 'spec_helper'

describe HomeController do
  let(:submission) { mock_model(Submission, save: true, :user= => true) }

  describe "GET 'index'" do
    it "assigns all submissions as @submissions" do
      Submission.stub(:accessible_by).and_return([submission])
      Submission.should_receive(:accessible_by)
      get :index
      assigns(:submissions).should eq([submission])
    end

    it "paginates the submissions 6 per page" do
      user = FactoryGirl.create(:user)
      FactoryGirl.create_list(:submission, 7, user: user)
      get :index
      expect(assigns(:submissions).count).to eq(6)
    end
  end
end
