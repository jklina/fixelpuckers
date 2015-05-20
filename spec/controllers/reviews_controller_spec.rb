require 'spec_helper'

describe ReviewsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:review) { FactoryGirl.create(:review) }
  let(:submission) { FactoryGirl.create(:submission, id: 1) }
  let(:review_attrs) { {"comment"=>"Whoa", "rating"=>"100"} }
  let(:invalid_review_attrs) { {"comment"=>"", "rating"=>""} }

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(controller).to receive(:current_user).and_return(user)
        post :create, submission_id: submission, id: review,
          review: review_attrs
      end

      it "finds the submission that will build the review" do
        expect(assigns(:submission)).to eq(submission)
      end

      it "creates a new Review from the given submission" do
        expect(Review.last.comment).to eq('Whoa')
        expect(Review.last.rating).to eq(100)
      end

      it "updates the submission rankings" do
        submission.reload
        expect(submission.average_rating).to eq(100)
      end

      it "redirects to the submission page" do
        expect(response).to redirect_to(submission_path(submission))
      end

      it "flashes a successful notice" do
        expect(flash[:notice]).to match(/^Review was successfully created/)
      end
    end

    describe "with invalid params" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(controller).to receive(:current_user).and_return(user)
        post :create, submission_id: submission, id: review,
          review: invalid_review_attrs
      end

      it "creates a new Review from the given submission" do
        expect(assigns(:review)).to be_a_new(Review)
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("submissions/show")
      end
    end
  end

  describe "PATCH update" do
    context "when updated successfully" do
      before(:each) do
        allow(controller).to receive(:authorize)
        review.submission = submission
        review.save!
        patch :update, submission_id: submission, id: review,
          review: review_attrs
      end

      it { authorizes_the_action(with: review) }

      it "assigns @review to the review" do
        expect(assigns(:review)).to eq(review)
      end

      it "updates the review" do
        review.reload
        expect(review.comment).to eq('Whoa')
        expect(review.rating).to eq(100)
      end

      it "updates the submission rankings" do
        submission.reload
        expect(submission.average_rating).to eq(100)
      end

      it "redirects to the submission page" do
        expect(response).to redirect_to(submission_path(submission))
      end

      it "flashes a successful notice" do
        expect(flash[:notice]).to match(/^Review was successfully updated/)
      end
    end

    describe "with invalid params" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(review).to receive(:update).and_return(false)
        allow(submission).to receive(:update_average_rating)
        allow(Review).to receive(:find).and_return(review)
        allow(Submission).
          to receive_message_chain(:friendly, :find).and_return(submission)
        patch :update, submission_id: submission, id: review, review: review_attrs
      end

      it "assigns the review as review" do
        expect(assigns(:review)).to eq(review)
      end

      it "re-renders the 'edit' template" do
        expect(response).to render_template("submissions/show")
      end
    end
  end

  describe "DELETE destroy" do
    context "when the user owns the review they're trying to delete" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(review).to receive(:destroy)
        allow(submission).to receive(:update_average_rating)
        allow(Review).to receive(:find).and_return(review)
        allow(Submission).
          to receive_message_chain(:friendly, :find).and_return(submission)
        get :destroy, submission_id: submission, id: review
      end

      it { authorizes_the_action(with: review) }

      it "assigns @review to the review" do
        expect(assigns(:review)).to eq(review)
      end

      it "destroys the review" do
        expect(review).to have_received(:destroy)
      end

      it "updates the submission rankings" do
        expect(submission).to have_received(:update_average_rating)
      end
    end

  end
end
