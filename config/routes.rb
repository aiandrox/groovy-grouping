Rails.application.routes.draw do
  root 'teams#new'
  resources :teams, param: :ref_uuid, only: %i[new create show]
  resources :teams, param: :edit_uuid, only: %i[edit update destroy] do
    resources :users, only: %i[create destroy]
  end
  resources :events, param: :ref_uuid, only: %i[new create show]
  resources :events, param: :edit_uuid, only: %i[edit update destroy]
end
