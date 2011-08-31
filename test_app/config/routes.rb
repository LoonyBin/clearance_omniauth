Rails.application.routes.draw do
  get "welcome/index"
  root :to => "welcome#index"

  mount ClearanceOmniauth::Engine => "/auth"
end
