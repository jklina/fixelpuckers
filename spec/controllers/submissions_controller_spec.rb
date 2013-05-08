require 'spec_helper'

describe SubmissionsController do
  let(:submission) { stub_model(Submission, id: '37') }
  before(:each) do
    mock_all_abilities
  end

  describe "GET index" do
    it "assigns all submissions as submissions" do
      get :index
      expect(assigns(:submissions)).to eq(Submission.all)
    end
  end

  describe "GET show" do
    before(:each) do
      Submission.stub(:find).and_return(submission)
    end

    it "assigns the requested submission as submission" do
      get :show, id: submission
      expect(assigns(:submission)).to eq(submission)
    end

    context "if current_user is present" do
      it "finds or creates a review and assigns it to @review" do
        review = stub()
        user = FactoryGirl.create(:user)
        submission.stub(:find_or_build_review_from).and_return(review)
        controller.stub(:current_user).and_return(user)
        get :show, id: submission
        expect(assigns(:review)).to eq(review)
      end
    end

    context "if current_user is not present" do
      it "does not find or creates a review and assign it to @review" do
        Submission.stub(:find).and_return(submission)
        controller.stub(:current_user).and_return(nil)
        submission.should_not_receive(:find_or_build_review_from)
        get :show, id: submission
      end
    end
  end

  describe "GET new" do
    it "assigns a new submission as submission" do
      get :new
      expect(assigns(:submission)).to be_a_new(Submission)
    end
  end

  describe "GET edit" do
    it "assigns the requested submission as submission" do
      Submission.stub(:find).and_return(submission)
      Submission.should_receive(:find).with(submission.to_param)
      get :edit, id: submission
      expect(assigns(:submission)).to eq(submission)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        @submission_attrs = FactoryGirl.attributes_for(:submission)
        @user = FactoryGirl.create(:user)
        controller.stub(:current_user).and_return(@user)
        submission.stub(:user=).and_return(true)
      end

      it "creates a new Submission" do
        expect { 
          post :create, submission: @submission_attrs
        }.to change(Submission, :count).by(1)
      end

      it "assigns a newly created submission as submission" do
        Submission.stub(:new).and_return(submission)
        post :create, submission: submission 
        expect(assigns(:submission)).to eq(submission)
      end

      it 'assigns the submission user to the current user' do
        Submission.stub(:new).and_return(submission)
        submission.should_receive(:user=).with(@user)
        post :create, submission: submission
      end

      it "redirects to the created submission" do
        Submission.stub(:new).and_return(submission)
        submission.stub(:save).and_return(true)
        post :create, submission: submission 
        expect(response).to redirect_to(submission)
      end
    end

    describe "with invalid params" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        # Trigger the behavior that occurs when invalid params are submitted
        submission.stub(:save).and_return(false)
        # Needed to pass CanCan check
        controller.stub(:current_user).and_return(@user)
        post :create, submission: FactoryGirl.attributes_for(:invalid_submission)
      end

      it "assigns a newly created but unsaved submission as submission" do
        expect(assigns(:submission)).to be_a_new(Submission)
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) do 
      @submission = FactoryGirl.create(:submission)
    end
    describe "with valid params" do
      it "updates the requested submission" do
        put :update, 
          {
            id: @submission,
            submission: FactoryGirl.attributes_for(:submission, title: 'hi')
          }
          @submission.reload
          expect(@submission.title).to eq('hi')
      end

      it "assigns the requested submission as submission" do
        put :update, id: @submission, submisison: @submission
        assigns(:submission).should eq(@submission)
      end

      it "redirects to the submission" do
        put :update, id: @submission, submisison: @submission
        response.should redirect_to(@submission)
      end
    end

    describe "with invalid params" do
      before(:each) do
        @invalid_sub = FactoryGirl.attributes_for(:invalid_submission)
      end
      it "assigns the submission as submission" do
        put :update, id: @submission, submission: @invalid_sub
        expect(assigns(:submission)).to eq(@submission)
      end

      it "re-renders the 'edit' template" do
        put :update, id: @submission, submission: @invalid_sub
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do 
      @submission = FactoryGirl.create(:submission)
    end

    it "destroys the requested submission" do
      expect {
        delete :destroy, id: @submission
      }.to change(Submission, :count).by(-1)
    end

    it "redirects to the submissions list" do
      delete :destroy, id: @submission
      expect(response).to redirect_to(submissions_url)
    end
  end
end
