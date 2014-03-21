require 'spec_helper'

describe FeaturesController do
  describe "GET index" do
    it "fetches all the features" do
      features = double("features")
      Feature.stub_chain(:page, :per).and_return(features)
      get :index
      expect(assigns(:features)).to eq(features)
    end
  end
end
