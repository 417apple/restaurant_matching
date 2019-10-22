Rails.application.routes.draw do


  get 'users/index'
  get 'users/show'


  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
}


  root to: "restaurants#index"

  resources :restaurants do
    resource :likes, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update, :new, :create]



  resources :messages, only: [:create]

  resources :rooms, only: [:create, :show, :index]

  resources :relationships, only: [:create, :destroy]

  get '/mypages/:id' => 'mypages#show'

  devise_scope :user do
    get '/profile_edit'  => 'users/registrations#profile_edit'
    patch 'profile_update', to: 'users/registrations#profile_update', as: 'profile_update'
  end

  resources :users do
    member do
     get :following, :followers
    end
  end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
