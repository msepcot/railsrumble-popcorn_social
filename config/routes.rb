MovieNight::Application.routes.draw do
  resources :auditorium, :only => [:index, :show] do
    match '/', :to => :create, :via => :post
    match '/:screen', :to => :show, :via => :get, :as => :screen
    match '/:screen/messages', :to => 'messages#create', :via => :post, :as => :messages
  end
  
  root :to => "auditorium#index"
end
