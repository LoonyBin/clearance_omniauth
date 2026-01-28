ClearanceOmniauth::Engine.routes.draw do
  # OmniAuth 2.x uses POST for callbacks by default
  post "/:provider/callback", to: "authentications#create"
  get "/:provider/callback", to: "authentications#create"
  get "/failure", to: "authentications#failure"

  resources :authentications, only: [:index, :destroy]
end
