Rails.application.routes.draw do
  root 'teams#new'
  resources :teams, param: :ref_uuid, only: %i[new create show]
  resources :teams, param: :edit_uuid, only: %i[edit update destroy] do
    resources :users, only: %i[create destroy]
    resources :events, only: %i[new create]
  end
  resources :events, param: :ref_uuid, only: %i[show] do
    resources :results, only: %i[create]
  end
  resources :events, param: :edit_uuid, only: %i[edit update destroy] do
    resources :attendances, only: %i[create destroy]
    resources :criteria, only: %i[new create destroy]
    resources :attendance_statuses, only: %i[create update]
  end
end
