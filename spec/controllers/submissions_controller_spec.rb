require 'spec_helper'

describe SubmissionsController do
  let(:submission) { stub_model(Submission, id: 'slugged-title') }
  let(:submission_attrs) { FactoryGirl.attributes_for(:submission, title: 'hi')}

  describe "GET show" do
    before(:each) do
      allow(submission).to receive(:increment_views!)
      Submission.stub_chain(:filtered_trash_for, :friendly, :find).
        and_return(submission)
    end

    it "assigns the requested submission as submission" do
      get :show, id: submission
      expect(assigns(:submission)).to eq(submission)
    end

    it "increments the submission's views" do
      get :show, id: submission
      expect(submission).to have_received(:increment_views!)
    end

    context "if current_user is present" do
      it "finds or creates a review and assigns it to @review" do
        review = double
        user = FactoryGirl.create(:user)
        allow(submission).to receive(:find_or_build_review_from).
          and_return(review)
        allow(controller).to receive(:signed_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
        get :show, id: submission
        expect(assigns(:review)).to eq(review)
      end
    end

    context "if current_user is not present" do
      it "does not find or creates a review and assign it to @review" do
        allow(Submission).to receive(:find).and_return(submission)
        allow(controller).to receive(:signed_in?).and_return(false)
        expect(submission).to_not receive(:find_or_build_review_from)
        get :show, id: submission
      end
    end
  end

  describe "GET new" do
    before(:each) do
      allow(controller).to receive(:authorize)
      get :new
    end

    it { authorizes_the_action }

    it "assigns a new submission as submission" do
      expect(assigns(:submission)).to be_a_new(Submission)
    end
  end

  describe "GET edit" do
    before(:each) do
      allow(controller).to receive(:authorize)
      Submission.stub_chain(:friendly, :find).and_return(submission)
      get :edit, id: submission
    end

    it { authorizes_the_action(with: submission) }

    it "assigns the requested submission as submission" do
      expect(assigns(:submission)).to eq(submission)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        allow(controller).to receive(:authorize)
        allow(controller).to receive(:current_user).and_return(@user)
        allow(submission).to receive(:author=)
        allow(Submission).to receive(:new).and_return(submission)
        allow(submission).to receive(:save).and_return(true)
        post :create, submission: submission_attrs
      end

      it { authorizes_the_action }

      it "creates a new Submission" do
        expect(Submission).
          to have_received(:new).with(submission_attrs.stringify_keys)
      end

      it "assigns a newly created submission as submission" do
        expect(assigns(:submission)).to eq(submission)
      end

      it 'assigns the submission user to the current user' do
        expect(submission).to have_received(:author=).with(@user)
      end

      it "redirects to the created submission" do
        expect(response).to redirect_to(submission)
      end
    end

    describe "with invalid params" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        allow(controller).to receive(:authorize)
        allow(submission).to receive(:save).and_return(false)
        allow(controller).to receive(:current_user).and_return(@user)
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

  describe "PATCH trash" do
    context "when trashed successfully" do
      before(:each) do
        Submission.stub_chain(:friendly, :find).and_return(submission)
        allow(submission).to receive(:toggle_trash!).and_return(true)
        allow(controller).to receive(:authorize)
        patch :trash, id: submission
      end

      it { authorizes_the_action(with: submission) }

      it "toggles the submissions trash status" do
        expect(submission).to have_received(:toggle_trash!)
      end

      it "redirects to the submission path" do
        expect(response).to redirect_to(submission)
      end

      it "flashes a notice letting the user know the sub was trashed" do
        expect(flash[:notice]).to match(/^This submission is un-trashed/)
      end
    end

    context "when trashed unsuccessfully" do
      before(:each) do
        allow(controller).to receive(:authorize).and_return(true)
        Submission.stub_chain(:friendly, :find).and_return(submission)
        allow(submission).to receive(:toggle_trash!).and_return(false)
        patch :trash, id: submission
      end

      it "toggles the submissions trash status" do
        expect(submission).to have_received(:toggle_trash!)
      end

      it "redirects to the submission path" do
        expect(response).to render_template("show")
      end
    end
  end

  describe "PATCH update" do
    describe "with valid params" do
      before(:each) do
        Submission.stub_chain(:friendly, :find).and_return(submission)
        allow(submission).to receive(:update_attributes).and_return(true)
        allow(controller).to receive(:authorize)
        put :update, id: submission, submission: submission_attrs
      end

      it { authorizes_the_action(with: submission) }

      it "assigns the requested submission as submission" do
        expect(assigns(:submission)).to eq(submission)
      end

      it "updates the requested submission" do
        expect(submission).
          to have_received(:update_attributes).
          with(submission_attrs.stringify_keys)
      end

      it "flashes a notice letting the user know the sub was updated" do
        expect(flash[:notice]).to match(/^Submission was successfully updated/)
      end

      it "redirects to the submission" do
        expect(response).to redirect_to(submission)
      end
    end

    describe "with invalid params" do
      before(:each) do
        Submission.stub_chain(:friendly, :find).and_return(submission)
        allow(submission).to receive(:update_attributes).and_return(false)
        allow(controller).to receive(:authorize)
        put :update, id: submission, submission: submission_attrs
      end

      it "assigns the requested submission as submission" do
        expect(assigns(:submission)).to eq(submission)
      end

      it "updates the requested submission" do
        expect(submission).
          to have_received(:update_attributes).
          with(submission_attrs.stringify_keys)
      end

      it "rerenders the new template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do 
      Submission.stub_chain(:friendly, :find).and_return(submission)
      allow(submission).to receive(:destroy)
      allow(controller).to receive(:authorize)
      delete :destroy, id: submission
    end

    it { authorizes_the_action(with: submission) }

    it "assigns the requested submission as submission" do
      expect(assigns(:submission)).to eq(submission)
    end

    it "destroys the requested submission" do
      expect(submission).to have_received(:destroy)
    end

    it "redirects to the submissions list" do
      expect(response).to redirect_to(submissions_path)
    end
  end
end
