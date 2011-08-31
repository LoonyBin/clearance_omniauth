module ClearanceOmniauth
  class Authentication < ActiveRecord::Base
    belongs_to :user
  end
end
