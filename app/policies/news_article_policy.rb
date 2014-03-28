require 'concerns/adminable'

class NewsArticlePolicy
  include Adminable

  admin_actions :index, :new, :create, :edit, :update, :destroy
end
