Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'application#api'
  post 'login' => 'authentication#login'
  post 'sign_up' => 'authentication#sign_up'
  resources :otps, only: [:create]
  resources :products, only: [:index]
end
