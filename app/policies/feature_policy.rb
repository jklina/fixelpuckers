require 'concerns/adminable'

class FeaturePolicy
  include Adminable

  admin_actions :new, :create, :edit, :update, :destroy
end
