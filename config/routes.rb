Rails.application.routes.draw do
  resources :categories, :only => [:index, :show, :create, :update], :format => false

  resources :todos, :only => [:index, :show, :create, :update], :format => false do
    collection do
      get :completed
    end

    member do
      post :complete
      post :incomplete
    end
  end

  mount Raddocs::App => "/docs", :as => :docs

  root :to => "root#index"
end
