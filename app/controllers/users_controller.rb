class UsersController < ApplicationController

  # The responder for viewing the signup form
  def new
     @user = User.new
  end

  # The responder for submitting the signup form.
  def create
     @user = User.new(user_params)
     if @user.save
        redirect_to login_url, :notice => "Sign up successful!"
     else
        render "new"
     end
  end

  # a user's profile page
  def show
     @user = User.find(params[:id])
  end

  # the edit page
  def edit
     @user = User.find(params[:id])
  end

  # update a user object
  def update
     @user = User.find(params[:id])
  end

  # Delete a user
  def destroy
     @user = User.find(params[:id])
  end

  # A listing of all users?
  def index
  end

  def user_params
     params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
