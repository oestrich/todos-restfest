Rails.application.routes.draw do
  resources :todos, :only => [:index], :format => false

  mount Raddocs::App => "/docs"

  root :to => "root#index"
end
