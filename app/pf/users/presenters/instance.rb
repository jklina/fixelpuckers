require 'action_view'
require 'delegate'

module Pf
  module Users
    module Presenters
      class Instance < SimpleDelegator
        include ActionView::Helpers::TagHelper
        include ActionView::Context 

        def self.for(user)
          new(user)
        end

        attr_reader :user

        def initialize(user)
          @user = user
          super(user)
        end

        def location
          if user.location.present?
            content_tag(:span) do
              content_tag(:i, "location", class: "ss-icon") +
              "#{user.location}"
            end
          else
            ''
          end
        end

        # def featured_at
        #   if user.featured_at.present?
        #     content_tag :li do
        #       content_tag(:i, class: "ss-icon")
        #       "Featured: #{user.featured_at}"
        #     end
        #   else
        #     nil
        #   end
        # end

        # def average_rating
        #   if user.average_rating.present?
        #     user.average_rating
        #   else
        #     "None"
        #   end
        # end

        # def downloads
        #   "#{user.downloads} Downloads"
        # end

        # def views
        #   "#{user.views} Views"
        # end

        # def number_of_reviews
        #   "#{user.reviews.count} Reviews"
        # end

        # def boxplot_ratings
        #   "#{Pf::Reviews.ratings(user.reviews).join(',')}"
        # end
      end
    end
  end
end
