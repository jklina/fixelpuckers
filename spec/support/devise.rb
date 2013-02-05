include Warden::Test::Helpers

# def create_user_and_login
#   password = 'please'
# 
#   visit '/users/sign_in'
#   fill_in "user_email", :with => user.email
#   fill_in "user_password", :with => user.password
#   click_button "Sign in"
# end
def create_logged_in_user
  user = FactoryGirl.create(:user)
  login(user)
  user
end

def login(user)
  login_as user, scope: :user
end
