Rails.application.routes.draw do
  get 'users/show'

  resources :items

  devise_for :users

  # resources :users do
  #   resources :items
  # end

  root 'users#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
