
#     session POST   /session(.:format)                     sessions#create
#             DELETE /session(.:format)                     sessions#destroy
# new_session GET    /session/new(.:format)                 sessions#new
#       users POST   /users(.:format)                       users#create
#    new_user GET    /users/new(.:format)                   users#new
#        user GET    /users/:id(.:format)                   users#show
# Write methods on the UsersController to allow new users to sign up.
# Users should be logged in immediately after they sign up.
class UsersController < ApplicationController


  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors]= @user.errors.full_messages
      render :new
    end
  end

  def show
    
  end
private
def user_params
  params.require(:user).permit(:email, :password)
end
end