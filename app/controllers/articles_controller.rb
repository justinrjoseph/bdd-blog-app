class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @articles = Article.all
  end
  
  def show
    @comment = @article.comments.build
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = current_user.articles.build(article_params)
    
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created"
      render :new
    end
  end
  
  def edit
    if @article.user != current_user
      flash[:danger] = "You can edit only your own articles."
      redirect_to root_path
    end
  end
  
  def update
    if @article.user != current_user
      flash[:danger] = "You can edit only your own articles."
      redirect_to root_path
    else
      if @article.update(article_params)
        flash[:success] = "Article has been updated"
        redirect_to @article
      else
        flash.now[:danger] = "Article has not been updated"
        render :edit
      end
    end
  end
  
  def destroy  
    if @article.destroy
      flash[:success] = "\"#{@article.title}\" has been deleted"
      redirect_to articles_path
    else
      flash[:danger] = "\"#{@article.title}\" has not been deleted"
      render :edit
    end
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :body)
  end
  
  def find_article
    @article = Article.find(params[:id])
  end
  
end
