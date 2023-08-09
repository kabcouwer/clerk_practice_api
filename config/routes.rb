Rails.application.routes.draw do
  post '/webhooks/:source', to: 'webhooks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v0 do
      resources :users, only: [:show]
    end
  end
end
