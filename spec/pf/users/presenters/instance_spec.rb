require 'action_view'
require 'users/presenters/instance'

describe Pf::Users::Presenters::Instance do
  describe "#location" do
    context "when a location is present" do
      it "displays the location in the correct html" do
        user = double(location: "Philadelphia")
        presenter = Pf::Users::Presenters::Instance.for(user)
        formatted_location = "<span><i class=\"ss-icon\">location</i>Philadelphia</span>"
        expect(presenter.location).to eq(formatted_location)
      end
    end


    context "when a location isn't present" do
      it "returns an empty string" do
        user = double(location: nil)
        presenter = Pf::Users::Presenters::Instance.for(user)
        expect(presenter.location).to eq('')
      end
    end
  end

  describe "presenter's inheritance" do
    it "forwards undefined methods in the presenter to the source object" do
      user = double(ohhai: "oh hai")
      presenter = Pf::Users::Presenters::Instance.for(user)
      expect(presenter.ohhai).to eq(user.ohhai)
    end
  end
end
