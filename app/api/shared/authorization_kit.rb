module Shared
  module AuthorizationKit
    # extend Grape::API::Helpers
    def self.included(mod)
      mod.helpers Pundit::Authorization
    end
  end
end
