require 'spec_helper'

describe Admin::FeaturesController do
  let(:feature) { stub_model(Feature) }
  let(:user) { double("user") }
  let(:submission) { stub_model(Submission) }
  let(:feature_attrs) { FactoryGirl.attributes_for(:feature, submission_id: submission.id.to_s) }

  describe "GET new" do
    before(:each) do
      Submission.stub_chain(:friendly, :find).and_return(submission)
      allow(controller).to receive(:current_user).
        and_return(FactoryGirl.create(:user))
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
        allow(controller).to receive(:authorize)
        allow(controller).to receive(:current_user).and_return(user)
        allow(Feature).to receive(:new).and_return(feature)
        allow(feature).to receive(:save).and_return(true)
        allow(feature).to receive(:author=)
        post :create, feature: feature_attrs
      end

      it { authorizes_the_action }

      it "creates a new Feature" do
        expect(Feature).
          to have_received(:new).with(feature_attrs.stringify_keys)
      end

      it "assigns a newly created feature as feature" do
        expect(assigns(:feature)).to eq(feature)
      end

      it "redirects to the categories page" do
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        allow(controller).to receive(:authorize)
        allow(Feature).to receive(:new).and_return(feature)
        allow(feature).to receive(:save).and_return(false)
        allow(feature).to receive(:author=)
        post :create, feature: feature_attrs
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET edit" do
    before(:each) do
      allow(controller).to receive(:authorize)
      allow(Feature).to receive(:find).and_return(feature)
      get :edit, id: feature
    end

    it { authorizes_the_action }

    it "finds the given feature" do
      expect(Feature).to have_received(:find).with(feature.id.to_s)
    end
  end

  describe "PATCH 'update'" do
    context "when updated successfully" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(feature).to receive(:update_attributes).and_return(true)
        allow(Feature).to receive(:find).and_return(feature)
        patch :update, id: feature, feature: feature_attrs
      end

      it { authorizes_the_action }

      it "assigns the requested feature as feature" do
        expect(assigns(:feature)).to eq(feature)
      end

      it "updates the attributes with the given attributes" do
        expect(feature).
          to have_received(:update_attributes).
          with(feature_attrs.stringify_keys)
      end

      it "redirects to the categories path" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "when update fails" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(feature).to receive(:update_attributes).and_return(false)
        allow(Feature).to receive(:find).and_return(feature)
        patch :update, id: feature, feature: feature_attrs
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end
    end
  end

  describe "GET 'delete'" do
    context "when deleted successfully" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(feature).to receive(:destroy).and_return(true)
        allow(Feature).to receive(:find).and_return(feature)
        delete :destroy, id: feature
      end

      it "finds the feature" do
        expect(assigns(:feature)).to eq(feature)
      end
     
      it "deletes the feature" do
        expect(feature).to have_received(:destroy)
      end

      it "redirects to the features path" do
        expect(response).to redirect_to(features_path)
      end
    end

    context "when the feature isn't deleted" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(feature).to receive(:destroy).and_return(false)
        allow(Feature).to receive(:find).and_return(feature)
        delete :destroy, id: feature
      end

      it "redirects to the features path" do
        expect(response).to redirect_to(features_path)
      end
    end
  end
end
