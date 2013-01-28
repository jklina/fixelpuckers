RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end

def login(user)
  visit '/users/sign_in'
  fill_in "user_email", :with => user.email
  fill_in "user_password", :with => user.password
  click_button "Sign in"
end
