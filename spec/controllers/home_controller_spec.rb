require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "assigns all submissions as @submissions" do
      FactoryGirl.create(:submission)
      submissions = Submission.all
      get :index
      expect(assigns(:submissions)).to eq(submissions)
    end

    it "returns submissions through the accessible_by method" do
      Submission.stub_chain(:accessible_by, :page, :per)
      expect(Submission).to receive(:accessible_by)
      get :index
    end

    it "paginates the submissions 6 per page" do
      user = FactoryGirl.create(:user)
      FactoryGirl.create_list(:submission, 7, user: user)
      get :index
      expect(assigns(:submissions).count).to eq(6)
    end
  end
end
