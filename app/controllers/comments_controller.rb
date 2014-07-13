class CommentsController < ApplicationController

   def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.create(comment_params)
      @comment.user = current_user
      if @comment.save
         redirect_to post_path(@post), :notice => "Your comment was posted!"
      else
         redirect_to post_path(@post), :notice => "Your comment was not posted!"
      end
   end

   def update
   end

   def destroy
   end

   private

   def comment_params
      params.require(:comment).permit(:body)
   end

end
