require 'spec_helper'

describe Category do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }
  it { should have_many(:submissions) }
end
