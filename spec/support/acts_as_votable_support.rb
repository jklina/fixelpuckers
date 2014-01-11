shared_examples "a votable" do
  let(:votable) { FactoryGirl.create(described_class.name.underscore.to_sym) }
  let(:user) { stub_model(User) }

  it "can receive votes" do
    votable.liked_by user
    expect(votable.votes.size).to eq(1)
  end
end
