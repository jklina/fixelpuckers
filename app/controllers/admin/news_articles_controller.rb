class Admin::NewsArticlesController < InheritedResources::Base
  before_action :authorize_news_article
  before_action :friendly_find_news_article, only: [:edit, :update, :destroy]
  actions :new, :create, :edit, :update, :index, :destroy

  private

  def build_resource_params
    [params.fetch(:news_article, {}).permit(:title, :story)]
  end

  def friendly_find_news_article
    @news_article = NewsArticle.friendly.find(params[:id])
  end

  def authorize_news_article
    authorize NewsArticle
  end
end
