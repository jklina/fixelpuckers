require 'admin_dashboard_policy'
require 'support/policies_support'

describe AdminDashboardPolicy do
  it_should_behave_like "an adminable policy with actions", [:index]
end
