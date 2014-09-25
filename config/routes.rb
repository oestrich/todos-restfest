Rails.application.routes.draw do
  resources :todos, :only => [:index, :show, :create], :format => false do
    collection do
      get :completed
    end

    member do
      post :complete
      post :incomplete
    end
  end

  mount Raddocs::App => "/docs"

  root :to => "root#index"
end
