require 'spec_helper'

describe NewsArticle do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:story) }
end
