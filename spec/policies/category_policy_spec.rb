require 'category_policy'
require 'support/policies_support'

describe CategoryPolicy do
  it_should_behave_like "an adminable policy with actions",
    [:index, :new, :create, :update, :edit]
end
