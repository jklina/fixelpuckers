require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create(:user) }

  it { should have_many(:submissions) }
  it { should have_many(:comments) }

  it { should validate_presence_of (:email) }
  it { should validate_presence_of (:password) }
  it { should validate_presence_of (:username) }
  it { should validate_presence_of (:slug) }


  # Have to create an existing record for this to work correctly
  it do
    FactoryGirl.create(:user) 
    should validate_uniqueness_of(:username)
  end

  it { should ensure_length_of(:username).is_at_most(20) }

  it { should allow_value('user@user.org').for(:email) }
  it { should allow_value('user_me@user.jp').for(:email) }
  it { should allow_value('123@user.com').for(:email) }

  it { should_not allow_value('user@foo,com').for(:email) }
  it { should_not allow_value('user_at_foo.org').for(:email) }
  it { should_not allow_value('example.user@foo.').for(:email) }

  it "validates uniqueness of email" do
    expect(User.new(email: user.email).errors_on(:email)).
      to include("has already been taken")
  end

  describe '#find_or_build_comment_from' do
    it "finds the author's comment when the author has a comment" do
      @comment = FactoryGirl.create(:comment)
      expect(@comment.user.find_or_build_comment_from(@comment.author)).to eq(@comment)
    end

    it "instantiates a new comment when a comment doesn't exist from the author" do
      author = FactoryGirl.create(:user)
      expect(user.find_or_build_comment_from(author)).to be_a_new(Comment)
    end
  end
end
