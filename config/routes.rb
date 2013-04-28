Wharfmembers::Application.routes.draw do
  resources :members do
    member do
      get :renew
      get :complete
    end
    collection do
      post :bulk_action
      get :pending
      get :expired
    end
    resources :memberships, only: :destroy
  end


  root :to => 'members#index'
end
