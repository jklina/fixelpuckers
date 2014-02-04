require 'users/presenters/instance'

module Pf
  module Users
    def self.present(user)
      Pf::Users::Presenters::Instance.for(user)
    end
  end
end
