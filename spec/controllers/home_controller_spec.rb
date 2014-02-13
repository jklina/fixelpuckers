require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "assigns non trashed submissions as @submissions" do
      submissions = double
      Submission.stub_chain(:filtered_trash_for, :page, :per).
        and_return(submissions)
      get :index
      expect(assigns(:submissions)).to eq(submissions)
    end
  end
end
