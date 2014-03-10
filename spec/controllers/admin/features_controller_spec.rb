require 'spec_helper'

describe Admin::FeaturesController do
  let(:feature) { double("feature") }
  let(:user) { double("user") }
  let(:submission) { stub_model(Submission) }
  let(:feature_attrs) { FactoryGirl.attributes_for(:feature, submission_id: submission.id.to_s) }

  describe "GET new" do
    before(:each) do
      Submission.stub_chain(:friendly, :find).and_return(submission)
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
end
