require 'spec_helper'

describe FeaturesController, type: :controller do
  describe "GET index" do
    it "fetches all the features" do
      features = double("features")
      allow(Feature).to receive_message_chain(:page, :per).and_return(features)
      get :index
      expect(assigns(:features)).to eq(features)
    end
  end
end
