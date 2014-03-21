require 'spec_helper'

describe ReviewsController do
  let(:user) { stub_model(User) }
  let(:review) { stub_model(Review) }
  let(:submission) { stub_model(Submission) }
  let(:review_attrs) { {"comment"=>"MyText", "rating"=>"1"} }

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(controller).to receive(:current_user).and_return(user)
        review.stub(:save).and_return(true)
        submission.stub(:update_average_rating)
        Review.stub(:new).and_return(review)
        Submission.stub_chain(:friendly, :find).and_return(submission)
        post :create, submission_id: submission, id: review,
          review: review_attrs
      end

      it "finds the submission that will build the review" do
        expect(assigns(:submission)).to eq(submission)
      end

      it "creates a new Review from the given submission" do
        expect(Review).to have_received(:new).with(review_attrs)
      end

      it "saves the new review" do
        expect(review).to have_received(:save)
      end

      it "updates the submission rankings" do
        expect(submission).to have_received(:update_average_rating)
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
        allow(review).to receive(:save).and_return(false)
        allow(Review).to receive(:new).and_return(review)
        Submission.stub_chain(:friendly, :find).and_return(submission)
        post :create, submission_id: submission, id: review,
          review: review_attrs
      end

      it "creates a new Review from the given submission" do
        expect(Review).to have_received(:new).with(review_attrs)
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("submissions/show")
      end
    end
  end

  describe "PATCH update" do
    context "when updated successfully" do
      before(:each) do
        controller.stub(:authorize)
        review.stub(:update).and_return(true)
        submission.stub(:update_average_rating)
        Review.stub(:find).and_return(review)
        Submission.stub_chain(:friendly, :find).and_return(submission)
        patch :update, submission_id: submission, id: review,
          review: review_attrs
      end

      it { authorizes_the_action(with: review) }

      it "assigns @review to the review" do
        expect(assigns(:review)).to eq(review)
      end

      it "updates the review" do
        expect(review).to have_received(:update).with(review_attrs)
      end

      it "updates the submission rankings" do
        expect(submission).to have_received(:update_average_rating)
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
        controller.stub(:authorize)
        review.stub(:update).and_return(false)
        submission.stub(:update_average_rating)
        Review.stub(:find).and_return(review)
        Submission.stub_chain(:friendly, :find).and_return(submission)
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
        controller.stub(:authorize)
        review.stub(:destroy)
        submission.stub(:update_average_rating)
        Review.stub(:find).and_return(review)
        Submission.stub_chain(:friendly, :find).and_return(submission)
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
