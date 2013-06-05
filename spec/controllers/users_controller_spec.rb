require 'spec_helper'

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }
  before (:each) do
    mock_all_abilities
  end

  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => user.id
      expect(response).to be_success
    end

    it "should find the right user" do
      get :show, :id => user.id
      expect(assigns(:user)).to eq(user)
    end

    context "if current_user is present" do
      it "finds or creates a comment and assigns it to @comment" do
        user = double(find_or_build_comment_from: true, id: 22)
        author = double()
        User.stub(:find).and_return(user)
        controller.stub(:current_user).and_return(author)
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
