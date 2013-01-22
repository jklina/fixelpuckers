require 'spec_helper'

describe "Home Page" do
  context "when there are no submissions" do
    it "shouldn't display any submissions" do
      get root_path
      response.status.should be(200)
    end
  end
end
