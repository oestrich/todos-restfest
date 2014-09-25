Rails.application.routes.draw do
  resources :todos, :only => [:index, :show, :create], :format => false

  mount Raddocs::App => "/docs"

  root :to => "root#index"
end
