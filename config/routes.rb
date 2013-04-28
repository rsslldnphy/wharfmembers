Wharfmembers::Application.routes.draw do
  resources :members do
    member do
      get :renew
      get :complete
    end
    collection do
      get :pending
    end
    resources :memberships, only: :destroy
  end


  root :to => 'members#index'
end
