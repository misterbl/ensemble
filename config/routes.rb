Rails.application.routes.draw do

  resources :projects do
    resources :tracks
  end

  resources :projects do
    resources :comments
  end

  resources :projects do
    resources :branches
  end

  resources :branches do
    resources :tracks
  end

  resources :branches do
    resources :comments
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  root 'ensemble#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
