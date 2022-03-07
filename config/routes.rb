Rails.application.routes.draw do
  root 'home#page'
  resources :jobs
  devise_for :users
  get '/profile/:id/jobs', to: 'profile#jobs', as: 'profile_jobs'
  get '/profile/:id', to: 'profile#page', as: 'profile_page'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
