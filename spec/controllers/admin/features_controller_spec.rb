require 'spec_helper'

describe Admin::FeaturesController, type: :controller do
  let(:feature) { create(:feature) }
  let(:author) { create(:user) }
  let(:submission) { create(:submission) }
  let(:feature_attrs) { attributes_for(:feature, description: "hi", submission_id: submission.id.to_s) }

  before(:each) do
    allow(controller).to receive(:current_user).and_return(author)
    allow(controller).to receive(:authorize)
  end

  describe "GET new" do
    before(:each) do
      allow(controller).to receive(:authorize)
      get :new, id: submission
    end

    it { authorizes_the_action }

    it "finds the given submission" do
      expect(assigns(:submission)).to eq(submission)
    end

    it "assigns the requested feature as feature" do
      expect(assigns(:feature)).to be_a_new(Feature)
    end

    it "sets the feature's submission to the found submission" do
      expect(assigns(:feature).submission).to eq(submission)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        post :create, feature: feature_attrs
      end

      it { authorizes_the_action }

      it "creates the new feature" do
        expect(assigns(:feature)).to be_persisted
      end

      it "redirects to the categories page" do
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, feature: {feature:{}}
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET edit" do
    before(:each) do
      feature
      get :edit, id: feature
    end

    it { authorizes_the_action }

    it "finds the given feature" do
      expect(assigns(:feature)).to eq(feature)
    end
  end

  describe "PATCH 'update'" do
    context "when updated successfully" do
      before(:each) do
        patch :update, id: feature, feature: feature_attrs
      end

      it { authorizes_the_action }

      it "assigns the requested feature as feature" do
        expect(assigns(:feature)).to eq(feature)
      end

      it "updates the attributes with the given attributes" do
        expect(assigns(:feature).description).
          to eq(feature_attrs[:description])
      end

      it "redirects to the categories path" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "when update fails" do
      before(:each) do
        allow(controller).to receive(:authorize)
        patch :update, id: feature, feature: {description: ''}
      end

      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "GET 'delete'" do
    context "when deleted successfully" do
      before(:each) do
        delete :destroy, id: feature
      end

      it "finds the feature" do
        expect(assigns(:feature)).to eq(feature)
      end
     
      it "deletes the feature" do
        expect(Feature.all).to be_empty
      end

      it "redirects to the features path" do
        expect(response).to redirect_to(features_path)
      end
    end

    context "when the feature isn't deleted" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(feature).to receive(:destroy).and_return(false)
        delete :destroy, id: feature
      end

      it "redirects to the features path" do
        expect(response).to redirect_to(features_path)
      end
    end
  end
end
