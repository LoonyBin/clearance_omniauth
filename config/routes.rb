ClearanceOmniauth::Engine.routes.draw do
  match '/:provider/callback' => 'authentications#create'
  resources :authentications
  resources :users, :controller => 'users'
end
