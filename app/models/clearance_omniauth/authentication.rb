module ClearanceOmniauth
  class Authentication < ApplicationRecord
    belongs_to :user, class_name: "::User"

    validates :provider, presence: true
    validates :uid, presence: true, uniqueness: { scope: :provider }

    def provider_name
      provider == "open_id" ? "OpenID" : provider.titleize
    end
  end
end
