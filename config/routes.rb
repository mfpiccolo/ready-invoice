ReadyInvoice::Application.routes.draw do
  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  resources :invoices do
    get :update_template
  end
  get "/synch" => "plies#update_all"
end
