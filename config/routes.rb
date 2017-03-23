Rails.application.routes.draw do
  root 'home#index'
  resources :field_owners, :only => [:index, :new, :create] do 
    resources :fields, :only => [:index, :new, :create, :destroy]
  end
  resources :team_owners
  resources :teams
  resources :players
  resources :matches do
    member do
      get 'waiting'
    end
  end
  resources :match_requests
  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
