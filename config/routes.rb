ClearanceOmniauth::Engine.routes.draw do
  match '/:provider/callback' => 'authentications#create', via: [:get, :post]
  resources :authentications
  resources :users, controller: 'users'
end
