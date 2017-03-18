Rails.application.routes.draw do
  resources :field_owners, :only => [:index, :new, :create] do 
    resources :fields, :only => [:index, :new, :create, :destroy]
  end
  
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
