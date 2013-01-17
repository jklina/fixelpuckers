require 'spec_helper'

describe Submission do
  it { should validate_presence_of (:title) }
  it { should validate_presence_of (:description) }
  it { should validate_presence_of (:user_id) }

  it { should belong_to(:user) }
  it { should have_many(:reviews) }

  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:description) }
  it { should_not allow_mass_assignment_of(:user_id) }

  describe '#review_from' do
    it 'should return the review' do
      user = FactoryGirl.create(:user)
      submission = FactoryGirl.create(:submission)
      review = FactoryGirl.create(:review, user: user)
      another_review = FactoryGirl.create(:review)
      submission.reviews << review
      submission.reviews << another_review
      submission.review_from(user).should eq(review)
    end
  end
end
