class User < ActiveRecord::Base
  include Clearance::User
  has_many :authentications, :class_name => "ClearanceOmniauth::Authentication", :dependent => :destroy

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
end
