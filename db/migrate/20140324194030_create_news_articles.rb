class CreateNewsArticles < ActiveRecord::Migration
  def change
    create_table :news_articles do |t|
      t.string :title
      t.text :story
      t.string :slug

      t.timestamps
    end

    add_index :news_articles, :slug, unique: true
  end
end
