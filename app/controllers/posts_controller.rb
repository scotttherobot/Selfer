class PostsController < ApplicationController
   helper_method :can_edit

   def index
      @posts = Post.page(params[:page]).order("created_at DESC").includes(:comments).all
   end

   def create
      require_login
      @post = Post.new(post_params)
      @post.user = current_user
      if @post.save
         redirect_to post_url(@post), :notice => "Saved!"
      else
         render "new"
      end
   end
   
   def new
      require_login
      @post = Post.new
   end

   def edit
      @post = Post.find(params[:id])
      self_edit_only(@post)
   end

   def show
      @post = Post.find(params[:id])
   end

   def update
      @post = Post.find(params[:id])
      self_edit_only(@post)
      if @post.update(post_params)
         redirect_to post_url, :notice => "Saved!"
      else
         render "edit"
      end
   end

   def destroy
      @post = Post.find(params[:id])
      self_edit_only(@post)
      @post.destroy
      redirect_to posts_url, :notice => "Post deleted!"
   end

   private

   def post_params
      params.require(:post).permit(:body, :image)
   end

   def self_edit_only (post)
      if !can_edit(post)
         redirect_to post_url, :notice => "You don't have permission to edit this."
      else
      end
   end

   # A helper
   def can_edit (post)
      return true if current_user && (post.user.id == current_user.id || current_user.is_admin)
      return false
   end

end
