Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "auth/login", to: "authentications#authenticate"
      resources :users, except: %i(edit new)
      resources :campaigns, except: %i(edit new)
    end
  end
end
