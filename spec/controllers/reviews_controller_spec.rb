require 'spec_helper'

describe ReviewsController do
  let(:submission) { FactoryGirl.create(:submission) }

  describe "POST create" do
    let(:review_attrs) { FactoryGirl.attributes_for(:review) }
    before(:each) do
      # Need to stub ability so we can get past authorization
      @ability = Object.new
      @ability.extend(CanCan::Ability)
      controller.stub(:current_ability) { @ability }
      @ability.can :create, Submission
    end

    describe "with valid params" do
      it "finds the submission that will build the review" do
        put :create, submission_id: submission, review: review_attrs
        expect(assigns(:submission)).to eq(submission)
      end

      it "creates a new Review from the given submission" do
        expect(assigns(:review)).to eq(submission.reviews.last)
      end

      it 'assigns the review user to the current user' do
        user = FactoryGirl.create(:user)
        controller.stub(:current_user).and_return(user)
        put :create, submission_id: submission, review: review_attrs
        expect(assigns(:review).user).to eq(user)
      end

      it "redirects to the submission show page" do
        put :create, submission_id: submission, review: review_attrs
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

    it "should find the submission with the given id" do
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

  # describe "DELETE destroy" do
  #   it "destroys the requested review" do
  #     review = Review.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => review.to_param}, valid_session
  #     }.to change(Review, :count).by(-1)
  #   end

  #   it "redirects to the reviews list" do
  #     review = Review.create! valid_attributes
  #     delete :destroy, {:id => review.to_param}, valid_session
  #     response.should redirect_to(reviews_url)
  #   end
  end

end
