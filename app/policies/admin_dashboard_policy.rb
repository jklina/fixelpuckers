require 'concerns/adminable'

class AdminDashboardPolicy
  include Adminable

  admin_actions :index
end
