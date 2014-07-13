class ArticlesController < ApplicationController
   def index
      @articles = Article.order("created_at DESC").all
   end

   def new
      require_admin
      @article = Article.new
   end

   def create
      require_admin
      @article = Article.new(article_params)
      @article.user = current_user

      if @article.save
         redirect_to @article
      else
         render 'new'
      end
   end

   def edit
      require_admin
      @article = Article.find(params[:id])
   end

   def update
      require_admin
      @article = Article.find(params[:id])
      
      if @article.update(article_params)
         redirect_to @article
      else
         render 'edit'
      end
   end

   def show
      @article = Article.find(params[:id])
   end

   def destroy
      require_admin
      @article = Article.find(params[:id])
      @article.destroy
      
      redirect_to articles_path
   end

   private
      def article_params
         params.require(:article).permit(:title, :text)
      end
end
