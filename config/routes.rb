Wharfmembers::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/edit', to: 'devise/registrations#edit', as: :edit_user_registration
    put '/users',      to: 'devise/registrations#update'
  end

  resources :members do
    member do
      get :renew
    end
    collection do
      get :register
      post :join
      get :current
      get :pending
      get :expired
      get :mailing_list
      get :mailing_list_expired
      post :bulk_action
    end
    resources :memberships, only: :destroy
  end


  root :to => 'members#current'
end
