Rails.application.routes.draw do
  root 'teams#new'
  resources :events, param: :ref_uuid, only: %i[new show]
  resources :teams
end
