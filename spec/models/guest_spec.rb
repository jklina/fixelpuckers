require './app/models/guest'

describe Guest do
  let(:guest) { Guest.new }

  describe "#admin" do
    it "returns false" do
      expect(guest.admin).to be_false
    end
  end

  describe "#admin?" do
    it "returns false" do
      expect(guest.admin?).to be_false
    end
  end

  describe "#id" do
    it "returns nil" do
      expect(guest.id).to be_nil
    end
  end
end
