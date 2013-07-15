shared_examples "a presentable" do
  describe ".present" do
    it "fetchs a presenter given an ID" do
      presentable = double
      presenter = double
      presenter_factory = "#{described_class.to_s}::Presenters::Instance"
      stub_const(presenter_factory, double(for: presenter))
      expect(described_class.present(presentable)).to eq(presenter)
    end
  end
end
