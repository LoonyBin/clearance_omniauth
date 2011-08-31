module ClearanceOmniauth
  class Authentication < ActiveRecord::Base
    belongs_to :user
    def provider_name
      provider == 'open_id' ? "OpenID" : provider.titleize
    end
  end
end
