Rails.application.routes.draw do
  resources :days
  resources :weeks
  resources :schedules
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get 'days/:id/mark_completed', to: "days#mark_completed", as: 'mark_completed'
end
