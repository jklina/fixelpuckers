require 'spec_helper'

describe CategoriesController do
  describe "GET 'index'" do
    it "fetches all the categories" do
      categories = double
      allow(Category).to receive(:all).and_return(categories)
      get :index
      expect(assigns(:categories)).to eq(categories)
    end
  end
end
