Rails.application.routes.draw do

  root 'pages#home'

  devise_for 	:users,
  				path: "",
  				path_names: { sign_in: "login", sign_out: "logout", edit: "profile" },
  				controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations" }


  resources :users, only: [:show]
  # resources :rooms, except: [:destroy]
  resources :photos

  resources :rooms, except: [:destroy] do
  	resources :reservations, only: [:create]
    resources :reviews, only: [:create, :destroy]
  end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  resources :rooms
  
  get "/preload" => "reservations#preload"
  get "/preview" => "reservations#preview"
  get "/your_trips" => "reservations#your_trips"
  get "/your_reservations" => "reservations#your_reservations"

end
