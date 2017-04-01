Rails.application.routes.draw do
  
  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through

  get '/notifications' => 'notifications#index'

  root 'home#index'
  resources :world_messages
  resources :field_owners do 
    resources :fields
  end
  resources :team_owners
  resources :teams do
    member do
      get 'away'
    end
    resources :team_messages
  end
  resources :team_requests
  resources :players
  resources :matches do
    member do
      get 'waiting'
      get 'select'
    end
    resources :match_messages
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
  get 'signin' => 'sessions#new'
  get 'signed_in_index' => 'home#signed_in_index'
  get 'team_members' => 'teams#team_members'
  post 'signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'
  delete 'accept_team_request' => 'team_requests#accept'
  delete 'decline_team_request' => 'team_requests#decline'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
