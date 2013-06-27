require 'spec_helper'

describe Review do
  it { should validate_presence_of(:body) }

  it { should belong_to(:submission) }
  it { should belong_to(:user) }

  it { should allow_mass_assignment_of(:body) }
  it { should allow_mass_assignment_of(:rating) }

  it { should_not allow_mass_assignment_of(:user_id) }
  it { should_not allow_mass_assignment_of(:submission_id) }
end
