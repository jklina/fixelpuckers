require 'news_article_policy'
require 'support/policies_support'

describe NewsArticlePolicy do
  it_should_behave_like "an adminable policy with actions",
    [:index, :new, :create, :update, :edit, :destroy]
end
