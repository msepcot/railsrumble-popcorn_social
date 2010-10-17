MovieNight::Application.routes.draw do
  resources :auditorium, :only => [:index, :show] do
    match '/', :to => :create, :via => :post
    match '/:screen', :to => :show, :via => :get, :as => :screen
    match '/:screen/messages', :to => 'messages#create', :via => :post, :as => :messages
    match '/:screen/starts_in', :to => 'auditorium#starts_in'
  end

  match '/search', :to => "auditorium#search"
  
  root :to => "auditorium#index"
end
