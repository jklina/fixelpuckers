require 'submissions/presenters/instance'

module Pf
  module Submissions
    def self.present(submission)
      Pf::Submissions::Presenters::Instance.for(submission)
    end
  end
end
