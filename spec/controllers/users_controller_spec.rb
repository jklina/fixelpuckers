require 'spec_helper'

describe UsersController do
  let(:user) { stub_model(User) }
  let(:author) { stub_model(User) }

  describe "GET 'show'" do
    before(:each) { User.stub_chain(:friendly, :find).and_return(user) }
    context "if current_user is present" do
      before(:each) do
        allow(user).to receive(:find_or_build_comment_from).and_return(true)
        allow(controller).to receive(:signed_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(author)
        get :show, id: user
      end

      it "is successful" do
        expect(response).to be_success
      end

      it "finds the right user" do
        expect(assigns(:user)).to eq(user)
      end

      it "finds or creates a comment and assigns it to @comment" do
        expect(user).to have_received(:find_or_build_comment_from).with(author)
      end
    end

    context "if current_user is not present" do
      it "does not find or creates a comment and assign it to @comment" do
        expect(user).not_to receive(:find_or_build_comment_from)
        get :show, id: user
      end
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      controller.stub(:authorize)
      controller.stub(:current_user).and_return(user)
      get :edit, id: user
    end

    it "authorizes the action" do
      expect(controller).to have_received(:authorize).with(user)
    end

    it "assigns @user to the current_user" do
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "PATCH 'update'" do
    let(:user_attrs) do
      { "location" => "Philalephia", "url" => "www.w.com" }
    end
    context "when updated successfully" do
      before(:each) do
        controller.stub(:authorize)
        user.stub(:update).and_return(true)
        controller.stub(:current_user).and_return(user)
        patch :update, id: user, user: user_attrs
      end

      it "authorizes the action" do
        expect(controller).to have_received(:authorize).with(user)
      end

      it "assigns @user to the current_user" do
        expect(assigns(:user)).to eq(user)
      end

      it "updates the user" do
        expect(user).to have_received(:update).with(user_attrs)
      end

      it "redirects to the user page" do
        expect(response).to redirect_to(user_path(user))
      end

      it "flashes a successful notice" do
        expect(flash[:notice]).to match(/^Profile was successfully updated/)
      end
    end

    context "when update is unsuccessful" do
      before(:each) do
        controller.stub(:authorize)
        user.stub(:update).and_return(false)
        controller.stub(:current_user).and_return(user)
        patch :update, id: user, user: user_attrs
      end

      it "renders the edit action" do
        expect(response).to render_template(:edit)
      end
    end
  end
end
