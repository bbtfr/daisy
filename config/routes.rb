Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :accounts,
    controllers: {
      omniauth_callbacks: "accounts/omniauth_callbacks"
    }

  # Mobile JSON API
  mount DaisyAPI => '/api'

  get "/mobiles" => redirect("/mobile/index.html")

  root to: "home#index"

end
