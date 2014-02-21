require 'spec_helper'

describe CategoriesController do
  describe "GET show" do
    let(:category) { double("category") }
    let(:submissions) { double("submissions") }

    before(:each) do
      Category.stub_chain(:friendly, :find).and_return(category)
      category.stub_chain(:submissions, :filtered_trash_for, :page, :per).
        and_return(submissions)
      get :show, id: category
    end

    it "fetches the given category" do
      expect(assigns(:category)).to eq(category)
    end

    it "fetches the categories submissions and paginates them" do
      expect(assigns(:submissions)).to eq(submissions)
    end
  end
end
