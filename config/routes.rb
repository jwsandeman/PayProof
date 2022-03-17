Rails.application.routes.draw do
  get 'reviews/new'
  root 'home#page'
  patch '/jobs/:id/update', to: 'jobs#update_job', as: 'update_job'
  resources :jobs do
    resources :reviews
  end
  devise_for :users
  get '/profile/:id', to: 'profile#page', as: 'profile_page'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
