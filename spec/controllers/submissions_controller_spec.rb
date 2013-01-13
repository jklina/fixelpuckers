require 'spec_helper'

describe SubmissionsController do

  let(:submission) { stub_model(Submission, id: '37') }
  let(:review) { stub_model(Review) }
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SubmissionsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    before(:each) do
      submission.stub_chain(:reviews, :build).and_return(review)
      Submission.stub(:accessible_by).and_return([submission])
    end
    it "assigns all submissions as @submissions" do
      Submission.should_receive(:accessible_by)
      get :index, {}, valid_session
      assigns(:submissions).should eq([submission])
    end

    it "builds a new review for the submission" do

    end
  end

  describe "GET show" do
    before(:each) do
      Submission.stub(:find).and_return(submission)
      submission.stub_chain(:reviews, :build).and_return(review)
    end

    it "assigns the requested submission as @submission" do
      Submission.should_receive(:find).with(submission.to_param)
      get :show, {:id => submission.to_param}, valid_session
      assigns(:submission).should eq(submission)
    end

    it "builds a new review off of the given submission" do
      get :show, {:id => submission.to_param}, valid_session
      assigns(:review).should eq(review)
    end
  end

  describe "GET new" do
    it "assigns a new submission as @submission" do
      get :new, {}, valid_session
      assigns(:submission).should be_a_new(Submission)
    end
  end

  describe "GET edit" do
    it "assigns the requested submission as @submission" do
      Submission.stub(:find).and_return(submission)
      Submission.should_receive(:find).with(submission.to_param)
      get :edit, {:id => submission.to_param}, valid_session
      assigns(:submission).should eq(submission)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        # Need to stub user= to since its called in controller
        submission.stub(:user=).and_return(true)
        Submission.stub(:new).and_return(submission)
        # Need to stub ability so we can get past authorization
        @ability = Object.new
        @ability.extend(CanCan::Ability)
        controller.stub(:current_ability) { @ability }
        @ability.can :create, Submission
      end

      it "creates a new Submission" do
        Submission.should_receive(:new).with(submission.to_param)
        post :create, {submission: submission.to_param}, valid_session
      end

      it "assigns a newly created submission as @submission" do
        post :create, {submission: submission.to_param}, valid_session
        assigns(:submission).should eq(submission)
      end

      it 'assigns the submission user to the current user' do
        user = double('user')
        controller.stub(:current_user).and_return(user)
        submission.should_receive(:user=).with(user)
        post :create, {submission: submission.to_param}, valid_session
      end

      it "redirects to the created submission" do
        submission.stub(:save).and_return(true)
        post :create, {submission: submission.to_param}, valid_session
        response.should redirect_to(submission)
      end
    end

    describe "with invalid params" do
      before(:each) do
        # Trigger the behavior that occurs when invalid params are submitted
        submission.stub(:save).and_return(false)
        post :create, {:submission => {  }}, valid_session
      end
      it "assigns a newly created but unsaved submission as @submission" do
        assigns(:submission).should be_a_new(Submission)
      end

      it "re-renders the 'new' template" do
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before(:each) { Submission.stub(:find).and_return(submission) }
      it "updates the requested submission" do
        submission.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => submission.to_param, :submission => { "these" => "params" }}, valid_session
      end

      it "assigns the requested submission as @submission" do
        submission.stub(:update_attributes).and_return(true)
        put :update, {:id => submission.to_param}, valid_session
        assigns(:submission).should eq(submission)
      end

      it "redirects to the submission" do
        submission.stub(:update_attributes).and_return(true)
        put :update, {:id => submission.to_param}, valid_session
        response.should redirect_to(submission)
      end
    end

    describe "with invalid params" do
      before(:each) do
        # Trigger the behavior that occurs when invalid params are submitted
        Submission.stub(:find).and_return(submission)
        submission.stub(:update_attributes).and_return(false)
      end

      it "assigns the submission as @submission" do
        put :update, {:id => submission.to_param, :submission => {  }}, valid_session
        assigns(:submission).should eq(submission)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => submission.to_param, :submission => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      # Trigger the behavior that occurs when invalid params are submitted
      Submission.stub(:find).and_return(submission)
    end

    it "destroys the requested submission" do
      submission.should_receive(:destroy)
      delete :destroy, {:id => submission.to_param}, valid_session
    end

    it "redirects to the submissions list" do
      submission.stub(:destroy).and_return(true)
      delete :destroy, {:id => submission.to_param}, valid_session
      response.should redirect_to(submissions_url)
    end
  end
end
