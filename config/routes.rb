Rails.application.routes.draw do
  root "welcome#index"

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :edit, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    resources :listings
    resources :reservations
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  get "/listings" => "listings#all"
  post "/verify/:id" => "listings#verify", as: "verify"

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  post "/listings/:id/delete_photos/:photo_id" => "listings#destroy_image", as: "delete_photos"

end
