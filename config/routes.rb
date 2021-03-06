Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :studies, only: [:index, :create]
      get 'histories', controller: :studies, action: :history
      resources :goals, only: [:index, :show, :create, :update]
    end
    post   'signup',  controller: :users,    action: :create
    post   'signin',  controller: :sessions, action: :create
    delete 'signin', controller: :sessions, action: :destroy
    post   'refresh', controller: :refresh,  action: :create
  end
end
