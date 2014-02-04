require 'submissions'
require 'users'

module Pf
  module PresenterCoordinator
    def self.present(presentee)
      presenter = "Pf::#{presentee.class.name.pluralize}".
        constantize.present(presentee)
    end
  end
end
