Rails.application.routes.draw do

  resources :honeymoon_payments

  resources :rsvps, path: "rsvp" do
    get :search, on: :collection
    member do
      get :reply
      patch :respond
    end
  end

  get '/registry', to: "homepages#registry", as: "registry"
  get '/our_story', to: "homepages#our_story", as: "our_story"
  get '/party', to: "homepages#party", as: "party"
  get '/honeymoon', to: "homepages#honeymoon", as: "honeymoon"
  get '/directions', to: "homepages#directions", as: "directions"
  get '/contact_us', to: "homepages#contact_us", as: "contact_us"

  get '/login', to: 'sessions#new', as: 'login'
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  root to: "homepages#index"

end
