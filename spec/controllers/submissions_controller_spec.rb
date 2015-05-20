require 'spec_helper'

describe SubmissionsController, type: :controller do
  let(:author) { create(:user) }
  let(:submission) { create(:submission, author: author) }
  let(:submission_attrs) { attributes_for(:submission, title: 'hi')}
  let(:invalid_submission_attrs) { attributes_for(:submission, title: '')}

  describe "GET show" do
    it "assigns the requested submission as submission" do
      get :show, id: submission
      expect(assigns(:submission)).to eq(submission)
    end

    it "increments the submission's views" do
      get :show, id: submission
      submission.reload
      expect(submission.views).to eq(1)
    end

    context "if current_user is present" do
      it "finds or creates a review and assigns it to @review" do
        user = create(:user)

        sign_in_as(user)
        get :show, id: submission

        expect(assigns(:review)).to be_a_new(Review)
        expect(assigns(:review).author).to eq(user)
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
        sign_in_as(author)
        allow(controller).to receive(:authorize)
        post :create, submission: submission_attrs
        @submission = Submission.last
      end

      it { authorizes_the_action }

      it "assigns a newly created submission as submission" do
        expect(assigns(:submission)).to eq(@submission)
      end

      it 'assigns the submission user to the current user' do
        expect(@submission.author).to eq(author)
      end

      it "redirects to the created submission" do
        expect(response).to redirect_to(@submission)
      end
    end

    describe "with invalid params" do
      before(:each) do
        sign_in_as(author)
        allow(controller).to receive(:authorize)
        post :create, submission: invalid_submission_attrs
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
        sign_in_as(author)
        allow(controller).to receive(:authorize)
        patch :trash, id: submission
      end

      it { authorizes_the_action(with: submission) }

      it "toggles the submissions trash status" do
        submission.reload
        expect(submission.trashed?).to be_truthy
      end

      it "redirects to the submission path" do
        expect(response).to redirect_to(submission)
      end

      it "flashes a notice letting the user know the sub was trashed" do
        expect(flash[:notice]).to match(/^This submission is trashed/)
      end
    end

    context "when trashed unsuccessfully" do
      before(:each) do
        @submission = double("submission")
        allow(Submission).to receive_message_chain(:friendly, :find) do
          @submission
        end
        allow(controller).to receive(:authorize)
        allow(@submission).to receive(:toggle_trash!).and_return(false)
        patch :trash, id: 1
      end

      it "toggles the submissions trash status" do
        expect(@submission).to have_received(:toggle_trash!)
      end

      it "redirects to the submission path" do
        expect(response).to render_template("show")
      end
    end
  end

  describe "PATCH update" do
    describe "with valid params" do
      before(:each) do
        allow(controller).to receive(:authorize)
        put :update, id: submission, submission: submission_attrs
      end

      it { authorizes_the_action(with: submission) }

      it "assigns the requested submission as submission" do
        expect(assigns(:submission)).to eq(submission)
      end

      it "updates the requested submission" do
        submission.reload
        expect(submission.title).to eq("hi")
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
        allow(controller).to receive(:authorize)
        put :update, id: submission, submission: invalid_submission_attrs
      end

      it "assigns the requested submission as submission" do
        expect(assigns(:submission)).to eq(submission)
      end

      it "rerenders the new template" do
        expect(response).to render_template(:edit)
      end

      it "generates an error on the submission" do
        expect(submission.errors.include?(:title))
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do 
      allow(controller).to receive(:authorize)
      delete :destroy, id: submission
    end

    it { authorizes_the_action(with: submission) }

    it "assigns the requested submission as submission" do
      expect(assigns(:submission)).to eq(submission)
    end

    it "destroys the requested submission" do
      expect { submission.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "redirects to the submissions list" do
      expect(response).to redirect_to(submissions_path)
    end
  end
end
