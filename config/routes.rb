MovieNight::Application.routes.draw do
  resources :auditorium, :only => [:index, :show, :search] do
    match '/', :to => :create, :via => :post
    match '/:screen', :to => :show, :via => :get, :as => :screen
    match '/:screen/messages', :to => 'messages#create', :via => :post, :as => :messages
  end

  match '/search', :to => "auditorium#search"
  
  root :to => "auditorium#index"
end
