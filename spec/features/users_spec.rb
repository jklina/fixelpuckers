require 'spec_helper'

describe "Viewing a user's page" do
  it "should use friendly urls" do
    user = FactoryGirl.create(:user)
    user.to_param.should eq(user.slug)
  end
end
