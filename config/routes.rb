Rails.application.routes.draw do
  root 'home#index'
  resources :field_owners, :only => [:index, :new, :create] do 
    resources :fields, :only => [:index, :new, :create, :destroy]
  end
  resources :team_owners
  resources :teams do
    resources :team_messages
  end
  resources :players
  resources :matches do
    member do
      get 'waiting'
    end
  end
  resources :match_requests do
    collection do
      post 'join'
      get 'invite'
    end
    member do
      get 'accept'
      get 'decline'
    end
  end
  resources :team_requests
  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'
  delete 'accept_team_request' => 'team_requests#accept'
  delete 'decline_team_request' => 'team_requests#decline'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
