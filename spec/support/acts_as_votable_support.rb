shared_examples "a votable" do
  let(:votable) { create(described_class.name.underscore.to_sym) }
  let(:user) { create(:user) }

  it "can receive votes" do
    votable.liked_by user
    expect(votable.votes.size).to eq(1)
  end
end
