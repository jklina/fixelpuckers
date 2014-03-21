require 'active_support/concern'

module Adminable
  extend ActiveSupport::Concern

  included do
    attr_reader :user
  end

  module ClassMethods
    def admin_actions(*args)
      args.each do |admin_action|
        define_method("#{admin_action}?") do
          send(:user).send(:admin?)
        end
      end
    end
  end

  def initialize(user, adminable)
    @user = user
  end
end
