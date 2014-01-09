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

  it { should validate_uniqueness_of(:email) }

  it { should validate_confirmation_of(:password) }

  it { should ensure_length_of(:password).is_at_least(6) }
  it { should ensure_length_of(:username).is_at_most(20) }

  it { should allow_value('user@user.org').for(:email) }
  it { should allow_value('user_me@user.jp').for(:email) }
  it { should allow_value('123@user.com').for(:email) }

  it { should_not allow_value('user@foo,com').for(:email) }
  it { should_not allow_value('user_at_foo.org').for(:email) }
  it { should_not allow_value('example.user@foo.').for(:email) }


  it "creates a new instance given a valid attribute" do
    user
  end

  describe "password encryption" do
    it "has an encrypted password attribute" do
      expect(user).to respond_to(:encrypted_password)
    end

    it "set the encrypted password attribute" do
      expect(user.encrypted_password).not_to be_blank
    end
  end

  describe "#recent_submissions" do
    it "returns the x most recent submissions" do
      user = FactoryGirl.create(:user)
      submissions = FactoryGirl.create_list(:submission, 4, user: user)
      submissions.sort! { |a, b| b.created_at <=> a.created_at }
      expect(user.recent_submissions(2)).to eq(submissions[0..1])
    end
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
