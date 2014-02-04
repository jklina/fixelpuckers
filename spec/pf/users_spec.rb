require 'users'
require 'users/presenters/instance'

describe Pf::Users do
  describe ".present" do
    it "fetchs a presenter given an ID" do
      user = double
      presenter = double
      allow(Pf::Users::Presenters::Instance).
        to receive(:for).and_return(presenter)
      expect(Pf::Users.present(user)).to eq(presenter)
    end
  end
end


