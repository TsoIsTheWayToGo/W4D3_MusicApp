
#     session POST   /session(.:format)                     sessions#create
#             DELETE /session(.:format)                     sessions#destroy
# new_session GET    /session/new(.:format)                 sessions#new
#       users POST   /users(.:format)                       users#create
#    new_user GET    /users/new(.:format)                   users#new
#        user GET    /users/:id(.:format)                   users#show
class SessionsController < ApplicationController


  def new 
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if user
      login!(user)
      redirect_to user_url(user)
      
    else
      flash.now[:errors]= ["Incorrect username or password"]
      # debugger
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end





end