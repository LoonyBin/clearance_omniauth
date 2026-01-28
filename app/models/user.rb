class User < ApplicationRecord
  include Clearance::User
  has_many :authentications, class_name: "ClearanceOmniauth::Authentication", dependent: :destroy

  def apply_omniauth(omniauth)
    # Extract email from OmniAuth info if available and email is blank
    if email.blank? && omniauth["info"].present?
      self.email = omniauth["info"]["email"]
    end

    authentications.build(provider: omniauth["provider"], uid: omniauth["uid"])
  end

  def password_required?
    # Password is not required if user has OAuth authentications and isn't setting a password
    return false if authentications.any? && password.blank?
    super
  end
end
