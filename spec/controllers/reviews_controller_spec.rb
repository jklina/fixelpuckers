require 'spec_helper'

describe ReviewsController do
  let(:submission) { stub_model(Submission, to_param: '37') }
  let(:review) { stub_model(Review, to_param: '14') }
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ReviewsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  # describe "GET new" do
  #   it "assigns a new review as @review" do
  #     get :new, {}, valid_session
  #     assigns(:review).should be_a_new(Review)
  #   end
  # end

  # describe "GET edit" do
  #   it "assigns the requested review as @review" do
  #     review = Review.create! valid_attributes
  #     get :edit, {:id => review.to_param}, valid_session
  #     assigns(:review).should eq(review)
  #   end
  # end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        Submission.stub(:find).and_return(submission)
        # Need to stub user= to since its called in controller
        review.stub(:user=).and_return(true)
        # Need to stub ability so we can get past authorization
        @ability = Object.new
        @ability.extend(CanCan::Ability)
        controller.stub(:current_ability) { @ability }
        @ability.can :create, Submission
      end

      it "finds the submission that will build the review" do
        Submission.should_receive(:find).with(submission.to_param)
        post :create, submission_id: submission.to_param,
                      review: review.to_param
      end

      it "creates a new Review from the given submission" do
        submission.stub_chain(:reviews, :build).and_return(review)
        post :create, submission_id: submission.to_param,
                      review: review.to_param
        assigns(:review).should eq(review)
      end

      it 'assigns the submission user to the current user' do
        user = double('user')
        controller.stub(:current_user).and_return(user)
        submission.stub_chain(:reviews, :build).and_return(review)
        review.should_receive(:user=).with(user)
        post :create, submission_id: submission.to_param,
                      review: review.to_param
      end

      it "redirects to the submission show page" do
        submission.stub_chain(:reviews, :build).and_return(review)
        review.stub(:save).and_return(true)
        post :create, submission_id: submission.to_param,
                      review: review.to_param
        response.should redirect_to(submission)
      end
    end




    # end

    # describe "with invalid params" do
    #   before(:each) do
    #     # Trigger the behavior that occurs when invalid params are submitted
    #     submission.stub(:save).and_return(false)
    #     post :create, {:submission => {  }}, valid_session
    #   end
    #   it "assigns a newly created but unsaved submission as @submission" do
    #     assigns(:submission).should be_a_new(Submission)
    #   end

    #   it "re-renders the 'new' template" do
    #     response.should render_template("new")
    #   end
    # end
  end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     it "updates the requested review" do
  #       review = Review.create! valid_attributes
  #       # Assuming there are no other reviews in the database, this
  #       # specifies that the Review created on the previous line
  #       # receives the :update_attributes message with whatever params are
  #       # submitted in the request.
  #       Review.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
  #       put :update, {:id => review.to_param, :review => { "these" => "params" }}, valid_session
  #     end

  #     it "assigns the requested review as @review" do
  #       review = Review.create! valid_attributes
  #       put :update, {:id => review.to_param, :review => valid_attributes}, valid_session
  #       assigns(:review).should eq(review)
  #     end

  #     it "redirects to the review" do
  #       review = Review.create! valid_attributes
  #       put :update, {:id => review.to_param, :review => valid_attributes}, valid_session
  #       response.should redirect_to(review)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the review as @review" do
  #       review = Review.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Review.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => review.to_param, :review => {  }}, valid_session
  #       assigns(:review).should eq(review)
  #     end

  #     it "re-renders the 'edit' template" do
  #       review = Review.create! valid_attributes
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Review.any_instance.stub(:save).and_return(false)
  #       put :update, {:id => review.to_param, :review => {  }}, valid_session
  #       response.should render_template("edit")
  #     end
  #   end
  # end

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
  # end

end
