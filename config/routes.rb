Rails.application.routes.draw do
  get'/' => 'home#index'

  # get '/auth/instagram/callback' => "home#create_user"

  get '/callback' => "home#callback"

  get '/stats' => "home#stats"

  get '/homepage' => "home#homepage"

  post '/logout' => "home#logout"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
