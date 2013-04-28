Wharfmembers::Application.routes.draw do
  resources :members do
    member do
      get :renew
      get :complete
    end
    resources :memberships
  end


  root :to => 'members#index'
end
