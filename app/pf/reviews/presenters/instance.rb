require 'action_view/helpers/tag_helper'
require 'reviews'
require 'delegate'

module Pf
  module Reviews
    module Presenters
      class Instance < SimpleDelegator
        include ActionView::Helpers::TagHelper
        include ActionView::Context

        def self.for(review)
          new(review)
        end

        attr_reader :review

        def initialize(review)
          @review = review
          super(review)
        end

        def commentable_info
          "{votable_id: '#{review.id}', votable_type: '#{review.class.to_s}'"
        end
      end
    end
  end
end

