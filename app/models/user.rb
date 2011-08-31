class User < ActiveRecord::Base
  include Clearance::User
  has_many :authentications, :class_name => "ClearanceOmniauth::Authentication", :dependent => :destroy
end
