Rails.application.routes.draw do
  namespace :accounts do
    get 'dashboard/index'
  end

  root 'home#index'

  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :accounts do
    resources :dashboard, only: :index
  end
end
