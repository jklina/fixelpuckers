require 'feature_policy'
require 'support/policies_support'

describe FeaturePolicy do
  it_should_behave_like "an adminable policy with actions",
    [:new, :create, :update, :edit, :destroy]
end
