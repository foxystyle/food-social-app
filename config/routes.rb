Rails.application.routes.draw do
  get 'votes/create'

  root 'static_pages#index'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users
  resources :posts, only: [:create, :show, :edit, :destroy, :update]
end
