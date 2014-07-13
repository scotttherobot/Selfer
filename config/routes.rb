Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # auth stuff
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  post "login" => "sessions#create", :as => "login_submit"
  get "signup" => "users#new", :as => "signup"
  resources :users

  #post stuff
  resources :posts do
     resources :comments
  end
end
