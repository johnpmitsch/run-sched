Rails.application.routes.draw do
  resources :schedules
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
