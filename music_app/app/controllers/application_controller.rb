# session POST   /session(.:format)                     sessions#create
#         DELETE /session(.:format)                     sessions#destroy
# new_session GET    /session/new(.:format)                 sessions#new
#   users POST   /users(.:format)                       users#create
# new_user GET    /users/new(.:format)                   users#new
#    user GET    /users/:id(.:format)                   users#show

class ApplicationController < ActionController::Base
    
    helper_method :current_user, :logged_in? 
    def login!(user)
        session[:session_token] = user.reset_session_token!
    end
    
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token]) 
    end
    
    def logout!
        if current_user
            current_user.reset_session_token!
        end
        session[:session_token]
    end
    
    def logged_in?
        !!current_user
    end
    
end