require 'spec_helper'
require "cancan/matchers"

describe User do

  let(:user) { FactoryGirl.create(:user) }

  it { should have_many(:submissions) }

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password) } 
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:remember_me) }

  it { should validate_presence_of (:email) }
  it { should validate_presence_of (:password) }

  it { should validate_uniqueness_of(:email) }

  it { should validate_confirmation_of(:password) }

  it { should ensure_length_of(:password).is_at_least(6) }

  it { should allow_value('user@user.org').for(:email) }
  it { should allow_value('user_me@user.jp').for(:email) }
  it { should allow_value('123@user.com').for(:email) }

  it { should_not allow_value('user@foo,com').for(:email) }
  it { should_not allow_value('user_at_foo.org').for(:email) }
  it { should_not allow_value('example.user@foo.').for(:email) }


  it "should create a new instance given a valid attribute" do
    user
  end

  describe "password encryption" do
    it "should have an encrypted password attribute" do
      user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      user.encrypted_password.should_not be_blank
    end
  end

  describe 'abilities' do
    subject { ability }
    let(:ability) { Ability.new(user) }
    let(:user) { nil }

    context 'when is a normal user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:a_submisison) { Submission.new }
      let(:her_submission) do
        s = Submission.new
        s.user = user
        s
      end
      it { should be_able_to(:manage, her_submission) }

      it { should be_able_to(:read, a_submission) }
      it { should_not be_able_to(:manage, a_submission) }
    end
  end

end
