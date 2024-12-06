Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Blorgh::Engine, at: "/blog"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "quizzes#index"

  resources :quizzes, only: [:index, :show], param: :token do
    post :join, on: :member
  end

  namespace :admins do
    resources :quizzes, only: [:new, :create, :index, :show]
  end
end
