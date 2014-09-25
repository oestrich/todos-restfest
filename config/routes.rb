Rails.application.routes.draw do
  mount Raddocs::App => "/docs"
  root :to => "root#index"
end
