Rails.application.routes.draw do

  mount ClearanceOmniauth::Engine => "/clearance_omniauth"
end
