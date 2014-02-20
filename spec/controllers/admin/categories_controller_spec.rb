require 'spec_helper'

describe Admin::CategoriesController do
  let(:category) { double("category") }
  let(:category_attrs) { FactoryGirl.attributes_for(:category) }
  let(:categories) { double("categories") }

  describe "GET 'index'" do
    before(:each) do
      allow(controller).to receive(:authorize)
      allow(Category).to receive(:all).and_return(categories)
      get :index
    end

    it { authorizes_the_action }

    it "fetches all the categories" do
      expect(assigns(:categories)).to eq(categories)
    end
  end

  describe "GET new" do
    before(:each) do
      allow(controller).to receive(:authorize)
      get :new
    end

    it { authorizes_the_action }

    it "assigns the requested category as category" do
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(Category).to receive(:new).and_return(category)
        allow(category).to receive(:save).and_return(true)
        post :create, category: category_attrs
      end

      it { authorizes_the_action }

      it "creates a new Submission" do
        expect(Category).
          to have_received(:new).with(category_attrs.stringify_keys)
      end

      it "assigns a newly created category as category" do
        expect(assigns(:category)).to eq(category)
      end

      it "redirects to the categories page" do
        expect(response).to redirect_to(admin_categories_path)
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        allow(controller).to receive(:authorize)
        allow(Category).to receive(:new).and_return(category)
        allow(category).to receive(:save).and_return(false)
        post :create, category: category_attrs
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET edit" do
    before(:each) do
      allow(controller).to receive(:authorize)
      Category.stub_chain(:friendly, :find).and_return(category)
      get :edit, id: category
    end

    it { authorizes_the_action }

    it "assigns the requested category as category" do
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "PATCH 'update'" do
    context "when updated successfully" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(category).to receive(:update_attributes).and_return(true)
        Category.stub_chain(:friendly, :find).and_return(category)
        patch :update, id: category, category: category_attrs
      end

      it { authorizes_the_action }

      it "assigns the requested category as category" do
        expect(assigns(:category)).to eq(category)
      end

      it "updates the attributes with the given attributes" do
        expect(category).
          to have_received(:update_attributes).
          with(category_attrs.stringify_keys)
      end

      it "redirects to the categories path" do
        expect(response).to redirect_to(admin_categories_path)
      end
    end

    context "when update fails" do
      before(:each) do
        allow(controller).to receive(:authorize)
        allow(category).to receive(:update_attributes).and_return(false)
        Category.stub_chain(:friendly, :find).and_return(category)
        patch :update, id: category, category: category_attrs
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end
    end
  end
end
