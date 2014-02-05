require 'action_view'
require 'reviews'
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
            content_tag(:span, submission.average_rating, id: "review-rating")
          else
            "None"
          end
        end

        def downloads
          "#{submission.downloads} Downloads"
        end

        def views
          "#{submission.views} Views"
        end

        def number_of_reviews
          content_tag(:span, submission.reviews.count, id: "review-count") +
            " Reviews"
        end

        def boxplot_ratings
          "#{Pf::Reviews.ratings(submission.reviews).join(',')}"
        end
      end
    end
  end
end
