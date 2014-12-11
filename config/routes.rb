Hiddeste::Application.routes.draw do
  get "notices/index"

  get "notices/new"

  get "notices/create"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get    "signin/:provider",   to: "users#signin"
  get    "users/",             to: "users#index"
  get    "users/:id",          to: "users#show"
  get    "users/:id/new",      to: "users#new"
  get    "users/:id/edit",     to: "users#edit"
  put    "users/:id",          to: "users#update"
  delete "users/:id",          to: "users#destroy"

  post   "user/events",        to: "user/events#create"
  delete "user/events/:id",    to: "user/events#destroy"

  get    "events",     to: "events#index"
  get    "events/new", to: "events#new"
  post   "events",     to: "events#create"
  get    "events/:id", to: "events#show"
  put    "events/:id", to: "events#update"
  delete "events/:id", to: "events#destroy"

  get  "notices",                     to: "notices#index"
  post "notices",                     to: "notices#create"
  post "notices/create",              to: "notices#create"
  get  "notices/new/event/:event_id", to: "notices#new"

  get "authentication"  => "statics#authentication"
  get "signout"         => "statics#signout"
  get "terms_of_use"    => "statics#terms_of_use"
  get "privacy_policy"  => "statics#privacy_policy"

  root :to => "statics#top"
end
