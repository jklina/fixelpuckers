require 'spec_helper'

describe Comment do
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:author_id) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:commentable_type) }

  it { should belong_to(:author) }
  it { should belong_to(:commentable) }

  it { should allow_mass_assignment_of(:body) }

  it { should_not allow_mass_assignment_of(:author_id) }
  it { should_not allow_mass_assignment_of(:user_id) }
end
