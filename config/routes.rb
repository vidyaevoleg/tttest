Rails.application.routes.draw do
  root 'application#root'
  devise_for :users, only: [:invitations]
  resources :users, only: [:destroy] do
    post :invite, on: :collection
    post :remove, on: :member
  end
end
