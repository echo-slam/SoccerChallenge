Rails.application.routes.draw do
  resources :matches
  resources :team_owners
  resources :players

  resources :teams do
    resources :match_requests, :only => [:create, :index, :destroy]
  end
  
  resources :field_owners, :only => [:index, :new, :create] do 
    resources :fields, :only => [:index, :new, :create, :destroy]
  end

  get 'signin' => 'sessions#new'

  post 'signin' => 'sessions#create'

  delete 'signout' => 'sessions#destroy'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
