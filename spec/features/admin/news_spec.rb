require 'spec_helper'

describe "News Articles" do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:news_article) { FactoryGirl.create(:news_article) }

  it "an admin can view all the news articles in a table" do
    news_article
    visit(admin_news_articles_path(as: admin.id))
    expect(page).to have_content(news_article.title)
  end

  it "an admin can create a new news article" do
    visit(new_admin_news_article_path(as: admin.id))
    fill_in("Title", with: "New News!")
    fill_in("Story", with: "This is interesting info.")
    click_button("Create News article")
    article = NewsArticle.last
    expect(article.title).to eq("New News!")
    expect(article.story).to eq("This is interesting info.")
  end

  it "an admin can edit a news article" do
    visit(edit_admin_news_article_path(news_article, as: admin.id))
    expect(find_field('news_article_title').value).to eq(news_article.title)
    expect(find_field('news_article_story').value).to eq(news_article.story)
    fill_in("Title", with: "New News!")
    fill_in("Story", with: "This is interesting info.")
    click_button("Update News article")
    news_article.reload
    expect(news_article.title).to eq("New News!")
    expect(news_article.story).to eq("This is interesting info.")
  end

  it "an admin can destroy a news article" do
    news_article
    visit(admin_news_articles_path(as: admin.id))
    click_link("Delete")
    expect(current_path).to eq(admin_news_articles_path)
    expect(NewsArticle.all.size).to eq(0)
  end
end
