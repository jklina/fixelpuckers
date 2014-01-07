require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "assigns all submissions as @submissions" do
      FactoryGirl.create(:submission)
      submissions = Submission.page(1).per(6)
      get :index
      expect(assigns(:submissions)).to eq(submissions)
    end

    it "paginates the submissions 6 per page" do
      user = FactoryGirl.create(:user)
      FactoryGirl.create_list(:submission, 7, user: user)
      get :index
      expect(assigns(:submissions).count).to eq(6)
    end
  end
end
