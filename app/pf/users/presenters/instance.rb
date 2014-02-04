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
          end
        end

        def email
          if user.email.present?
            content_tag(:span) do
              content_tag(:i, "send", class: "ss-icon") +
              content_tag(:a, user.email, href: "mailto:#{user.email}")
            end
          end
        end

        def url
          if user.domain.present?
            content_tag(:span) do
              content_tag(:i, "world", class: "ss-icon") +
              content_tag(:a, user.domain, href: "http://#{user.domain}")
            end
          end
        end
      end
    end
  end
end
