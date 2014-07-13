class SessionsController < ApplicationController

   # The responder for viewing the login form.
   def new
   end

   # The responder for submitting the login form
   def create
      user = User.authenticate(params[:email], params[:password])
      if user
         # token = (0...20).map { ('a'..'z').to_a[rand(26)] }.join
         #session[:token] = token
         session[:user_id] = user.id
        #  user.update(session: token)
         redirect_to root_url, :notice => "Logged in!"            
      else
         flash.now.alert = "Invalid credentials."
         render "new"
      end
   end

   # The responder for logging out
   def destroy
      session[:user_id] = nil
      redirect_to root_url, :notice => "Logged out!"
   end

end
