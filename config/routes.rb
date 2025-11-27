Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  post "ai/assist", to: "ai#assist"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :projects, only: [:new, :create, :show, :update, :index] do
    resources :messages, only: [:create, :index]
  end
end
