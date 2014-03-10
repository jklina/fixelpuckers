require 'spec_helper'

describe Feature do
  it { should validate_presence_of (:description) }
  it { should validate_presence_of (:user_id) }

  it { should belong_to(:author).class_name('User') }
  it { should belong_to(:submission) }
end
