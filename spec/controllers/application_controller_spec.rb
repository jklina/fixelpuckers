require 'spec_helper'

describe ApplicationController do
  controller do
    def index
      render nothing: true
    end
  end

  describe "#fetch_categories" do
    it "fetches all the browsable categories" do
      category = FactoryGirl.create(:category)
      get :index
      expect(assigns(:browsable_categories)).to eq([category])
    end
  end

  describe "#fetch_news_article" do
    it "fetches the most recent news article" do
      earlier_article = FactoryGirl.create(:news_article)
      recent_article = FactoryGirl.create(:news_article)
      get :index
      expect(assigns(:current_news_article)).to eq(recent_article)
    end
  end
end
