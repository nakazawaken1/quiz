Rails.application.routes.draw do
  get 'users/new', as: 'users'
  post 'users/new', to: 'users#create'
  root to: 'questions#index', as: 'question'
  post '/answer', to: 'questions#answer'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
