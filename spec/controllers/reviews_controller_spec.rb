require 'spec_helper'

describe ReviewsController do
  let(:submission) { FactoryGirl.create(:submission) }

  describe "POST create" do
    let(:review_attrs) { FactoryGirl.attributes_for(:review) }
    
    describe "with valid params" do
      it "finds the submission that will build the review" do
        post :create, submission_id: submission, review: review_attrs
        expect(assigns(:submission)).to eq(submission)
      end

      it "creates a new Review from the given submission" do
        expect {
          post :create, submission_id: submission, review: review_attrs
        }.to change(Review, :count).by(1)
      end

      it 'assigns the review user to the current user' do
        user = FactoryGirl.create(:user)
        allow(controller).to receive(:current_user).and_return(user)
        post :create, submission_id: submission, review: review_attrs
        expect(assigns(:review).user).to eq(user)
      end

      it "updates the submission's average rating" do
        submission
        Submission.stub_chain(:friendly, :find).and_return(submission)
        expect(submission).to receive(:update_average_rating)
        post :create, submission_id: submission, review: review_attrs
      end

      it "redirects to the submission show page" do
        post :create, submission_id: submission, review: review_attrs
        expect(response).to redirect_to(submission)
      end
    end

    describe "with invalid params" do
      let(:invalid_review_attrs) { { rating: 1 }}
      before(:each) do
        # Trigger the behavior that occurs when invalid params are submitted
        put :create, submission_id: submission, review: invalid_review_attrs
      end

      it "assigns a newly created but unsaved review as @review" do
        expect(assigns(:review).rating).to eq(invalid_review_attrs[:rating])
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("submissions/show")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @review = FactoryGirl.create(:review)
      submission.reviews << @review
    end

    it "finds the submission with the given id" do
      put :update, { submission_id: submission, id: @review}
      expect(assigns(:submission)).to eq(submission)
    end

    describe "with valid params" do
      it "updates the requested review" do
        rating = rand(2..99)
        put :update, { submission_id: submission, id: @review,
                       review: FactoryGirl.attributes_for(:review, 
                                                          rating: rating) }
        @review.reload
        expect(@review.rating).to eq(rating)
      end

      it "assigns the requested review as @review" do
        put :update, { submission_id: submission,
                       id: @review,
                       review: FactoryGirl.attributes_for(:review) }
        expect(assigns(:review)).to eq(@review)
      end

      it "updates the submission's average rating" do
        rating = rand(2..99)
        Submission.stub_chain(:friendly, :find).and_return(submission)
        expect(submission).to receive(:update_average_rating)
        put :update, { submission_id: submission, id: @review,
                       review: FactoryGirl.attributes_for(:review, 
                                                          rating: rating) }
      end

      it "redirects to the review" do
        put :update, { submission_id: submission,
                       id: @review,
                       review: FactoryGirl.attributes_for(:review) }
        expect(response).to redirect_to(submission)
      end
    end

    describe "with invalid params" do
      before(:each) do
        @invalid_review_attrs = FactoryGirl.attributes_for(:invalid_review)
        put :update, { submission_id: submission,
                       id: @review,
                       review: @invalid_review_attrs }
      end

      it "assigns the review as @review" do
        expect(assigns(:review)).to eq(@review)
      end

      it "re-renders the 'edit' template" do
        expect(response).to render_template("submissions/show")
      end
    end
  end

  describe "DELETE destroy" do
    context "when the user owns the review they're trying to delete" do
      before(:each) do
        @review = FactoryGirl.create(:review)
        submission.reviews << @review
      end

      it "destroys the requested review" do
        expect {
          delete :destroy, {submission_id: submission, id: @review}
        }.to change(Review, :count).by(-1)
      end

      it "updates the submission's average rating" do
        expect(submission).to receive(:update_average_rating)
        Submission.stub_chain(:friendly, :find).and_return(submission)
        delete :destroy, {submission_id: submission, id: @review}
      end

      it "redirects to the review's submission" do
        delete :destroy, {submission_id: submission, id: @review}
        expect(response).to redirect_to(submission)
      end
    end

  end
end
