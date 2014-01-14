require 'spec_helper'

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET 'show'" do
    it "is successful" do
      get :show, id: user
      expect(response).to be_success
    end

    it "finds the right user" do
      get :show, :id => user.id
      expect(assigns(:user)).to eq(user)
    end

    context "if current_user is present" do
      it "finds or creates a comment and assigns it to @comment" do
        user = double(find_or_build_comment_from: true, id: 22)
        author = double
        User.stub_chain(:friendly, :find).and_return(user)
        allow(controller).to receive(:signed_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(author)
        expect(user).to receive(:find_or_build_comment_from).with(author)
        get :show, id: user
      end
    end

    context "if current_user is not present" do
      it "does not find or creates a comment and assign it to @comment" do
        expect(user).not_to receive(:find_or_build_comment_from)
        get :show, id: user
      end
    end
  end
end
