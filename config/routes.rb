Rails.application.routes.draw do
  resources :users, only: [:destroy] do
    post :invite, on: :collection
  end
end
