require 'spec_helper'

describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:author) { create(:user) }

  describe "GET 'show'" do
    context "if current_user is present" do
      before(:each) do
        sign_in_as(user)
        get :show, id: user
      end

      it "is successful" do
        expect(response).to be_success
      end

      it "finds the right user" do
        expect(assigns(:user)).to eq(user)
      end

      it "finds or creates a comment and assigns it to @comment" do
        expect(assigns(:comment).author).to eq(user)
      end
    end

    context "if current_user is not present" do
      it "does not find or creates a comment and assign it to @comment" do
        get :show, id: user
        expect(assigns(:comment)).to be_nil
      end
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      sign_in_as(user)
      allow(controller).to receive(:authorize)
      get :edit, id: user
    end

    it { authorizes_the_action(with: user) }

    it "assigns @user to the current_user" do
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "PATCH 'update'" do
    let(:user_attrs) do
      { "location" => "Philadelphia", "domain" => "www.w.com" }
    end

    context "when updated successfully" do
      before(:each) do
        allow(controller).to receive(:authorize)
        sign_in_as(user)
        patch :update, id: user, user: user_attrs
      end

      it { authorizes_the_action(with: user) }

      it "assigns @user to the current_user" do
        expect(assigns(:user)).to eq(user)
      end

      it "updates the user" do
        user.reload
        expect(user.location).to eq('Philadelphia')
        expect(user.domain).to eq('www.w.com')
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
        allow(controller).to receive(:authorize)
        sign_in_as(user)
        patch :update, id: user, user: { 'email' => '' }
      end

      it "renders the edit action" do
        expect(response).to render_template(:edit)
      end
    end
  end
end
