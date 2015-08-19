class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash[:error] = ""
    end
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :body)
  end
  
end
