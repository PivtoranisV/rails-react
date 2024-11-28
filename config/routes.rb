Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :books
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
  root "static#home"
  get "*path", to: "static#home", constraints: ->(req) { !req.xhr? && req.format.html? }
end
