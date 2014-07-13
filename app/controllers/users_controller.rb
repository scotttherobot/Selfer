class UsersController < ApplicationController
   helper_method :can_edit

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
     self_edit_only
     @user = User.find(params[:id])
  end

  # update a user object
  def update
     self_edit_only
     @user = User.find(params[:id])
     if @user.update(update_params)
        redirect_to user_url, :notice => "Update successful!"
     else
        render "edit"
     end
  end

  # Delete a user
  def destroy
     self_edit_only
     @user = User.find(params[:id])
     if @user.destroy
        redirect_to site_root, :notice => "Account deleted!"
     else
        render "edit", :notice => "Deletion failure!"
     end
  end

  # A listing of all users?
  def index
     @users = User.order("created_at DESC").all
  end

  private

  def user_params
     params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

  def update_params
     params.require(:user).permit(:email, :username, :avatar, :bio)
  end

  # Only the same user and admins can edit a user's profile
  def self_edit_only
     #if current_user.id != Integer(params[:id]) && !current_user.is_admin
     if !can_edit
        redirect_to user_url, :notice => "You don't have permission to do that."
     else
     end
  end

  # A view helper, returns true if the user should be able to edit.
  def can_edit
     return current_user && (current_user.id == Integer(params[:id]) || current_user.is_admin)
  end

end
