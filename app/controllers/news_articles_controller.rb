class NewsArticlesController < ApplicationController
  def index
    @news_articles = NewsArticle.all
  end

  def show
    @news_article = NewsArticle.friendly.find(params[:id])
  end
end
