require 'spec_helper'

describe Review do
  it { should validate_presence_of(:comment) }

  it { should belong_to(:submission) }
  it { should belong_to(:user) }
end
