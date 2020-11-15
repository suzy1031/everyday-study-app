Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :studies, only: [:index, :show]
    end
  end
end
