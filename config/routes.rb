Rails.application.routes.draw do
  root 'questions#home'
  post 'questions/answer', to: 'questions#answer'

  get 'questions', to: 'questions#index'
  
  get 'questions/new', to: 'questions#new'
  post 'questions', to: 'questions#create'
  
  get 'questions/:id', to: 'questions#edit'
  patch 'questions/:id', to: 'questions#update'
  
  delete 'questions/:id', to: 'questions#destroy'

  get 'signup', to: 'users#new'
  post 'users/create', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'sessions/create', to: 'sessions#create'

  post 'logout', to: 'sessions#destroy'

  get 'users/edit', to: 'users#edit'
  patch 'users/update', to: 'users#update'

  get 'categories', to: 'categories#index'

  get 'categories/new', to: 'categories#new'
  post 'categories', to: 'categories#create'

  get 'categories/:id', to: 'categories#edit'
  patch 'categories/:id', to: 'categories#update'

  delete 'categories/:id', to: 'categories#destroy'
end
