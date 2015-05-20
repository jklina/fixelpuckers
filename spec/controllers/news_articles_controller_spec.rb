require 'spec_helper'

describe NewsArticlesController, type: :controller do
  let(:news_article) { FactoryGirl.create(:news_article) }

  describe "GET index" do
    it "fetches all the news articles" do
      news_article
      get :index
      expect(assigns(:news_articles)).to eq([news_article])
    end
  end

  describe "GET show" do
    it "fetches the given news_article" do
      news_article
      get :show, id: news_article
      expect(assigns(:news_article)).to eq(news_article)
    end
  end
end
