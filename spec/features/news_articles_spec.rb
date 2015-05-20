require 'spec_helper'

feature "News Articles", type: :feature do
  let(:news_article) { create(:news_article) }
  feature "viewing a news article" do
    scenario "the headline appears at the top of the layout" do
      news_article
      visit(root_path)
      expect(page).to have_content(news_article.title)
    end
  end

  feature "clicking the headline to view whole article" do
    scenario "when the headline is clicked a user is taken to the full article" do
      news_article
      visit(root_path)
      click_link(news_article.title)
      expect(current_path).to eq(news_article_path(news_article))
      expect(page).to have_content(news_article.story)
    end
  end
end
