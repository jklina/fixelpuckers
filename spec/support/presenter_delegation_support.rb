shared_examples "an instance presenter" do
  describe "presenter's inheritance" do
    it "forwards undefined methods in the presenter to the source object" do
      presentee = double(ohhai: "oh hai")
      presenter = described_class.for(presentee)
      expect(presenter.ohhai).to eq(presentee.ohhai)
    end
  end
end
