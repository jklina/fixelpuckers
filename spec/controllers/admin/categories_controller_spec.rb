require 'spec_helper'

describe Admin::CategoriesController do
  let(:category) { FactoryGirl.create(:category) }
  let(:category_attrs) { FactoryGirl.attributes_for(:category) }

  describe "GET 'index'" do
    before(:each) do
      allow(controller).to receive(:authorize)
      get :index
    end

    it { authorizes_the_action }

    it "fetches all the categories" do
      expect(assigns(:categories)).to eq([category])
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
        post :create, category: category_attrs
      end

      it { authorizes_the_action }

      it "assigns a newly created category as category" do
        expect(assigns(:category)).to eq(Category.last)
      end

      it "redirects to the categories page" do
        expect(response).to redirect_to(admin_categories_path)
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        allow(controller).to receive(:authorize)
        post :create, category: {category:{}}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET edit" do
    before(:each) do
      allow(controller).to receive(:authorize)
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
        patch :update, id: category, category: category_attrs
      end

      it { authorizes_the_action }

      it "assigns the requested category as category" do
        expect(assigns(:category).name).to eq(category_attrs[:name])
      end

      it "redirects to the categories path" do
        expect(response).to redirect_to(admin_categories_path)
      end
    end

    context "when update fails" do
      before(:each) do
        allow(controller).to receive(:authorize)
        patch :update, id: category, category: {name: ''}
      end

      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end
    end
  end
end
