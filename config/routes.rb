Rails.application.routes.draw do
  root :controller => 'search', :action => :new
  match '/search/new', to: 'search#new', via: :get
  match '/search', to: 'search#search', via: :post
end
