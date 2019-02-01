Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #     session POST   /session(.:format)                     sessions#create
#             DELETE /session(.:format)                     sessions#destroy
# new_session GET    /session/new(.:format)                 sessions#new
#       users POST   /users(.:format)                       users#create
#    new_user GET    /users/new(.:format)                   users#new
#        user GET    /users/:id(.:format)                   users#show
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :bands
end
