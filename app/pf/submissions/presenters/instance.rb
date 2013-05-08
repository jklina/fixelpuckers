require 'action_view/helpers/tag_helper'
require 'delegate'

module Pf
  module Submissions
    module Presenters
      class Instance < SimpleDelegator
        include ActionView::Helpers::TagHelper
        include ActionView::Context 

        def self.for(submission)
          new(submission)
        end

        attr_reader :submission

        def initialize(submission)
          @submission = submission
          super(submission)
        end

        def featured_at
          if submission.featured_at.present?
            content_tag :li do
              content_tag(:i, class: "ss-icon")
              "Featured: #{submission.featured_at}"
            end
          else
            nil
          end
        end

        def average_rating
          if submission.average_rating.present?
            "User Rating: #{submission.average_rating}"
          else
            "User Rating: None"
          end
        end

        def downloads
          "#{submission.downloads} Downloads"
        end

        def views
          "#{submission.views} Views"
        end

        def number_of_reviews
          "#{submission.reviews.count} Reviews"
        end
      end
    end
  end
end