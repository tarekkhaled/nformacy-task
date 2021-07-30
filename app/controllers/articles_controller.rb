class ArticlesController < Api::BaseApi
  before_action :set_article, only: [:show, :update, :destroy, :approve]
  before_action only: [:create, :destroy] do
    authorized
  end
  before_action :is_admin?, only: [:approve, :destroy, :index]
  before_action :is_public_user?, only: [:index]

  # GET /articles
  def index
    if is_public_user?
      @articles = Article.where(status: :published)
    else
      if is_admin?
        @articles = Article.all
      else
        own_articles, other_articles = Article.all.partition { |article| article.user_id == current_user.id }
        other_articles = other_articles.select { |article| article.status == :published }
        @articles = {
          own_articles: own_articles,
          other_articles: other_articles
        }
      end
    end

    render json: @articles
  end

  # POST /articles
  def create
    creation_object = {
      title: article_params[:title],
      description: article_params[:description],
      user_id: current_user.id,
    }
    @article = Article.new(creation_object)
    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    if is_admin?
      @article.destroy
    else
      render json: { status: 'unauthorized', code: 401 }
    end
  end

  # Get /articles/1/approve
  def approve
    if is_admin?
      @article.update(status: :published)
      render json: @article
    else
      render json: { status: 'unauthorized', code: 401 }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  def is_public_user?
    !current_user
  end

  def is_admin?
    current_user && current_user.role == 'admin'
  end

  # Only allow a trusted parameter "white list" through.
  def article_params
    params.require(:article).permit(:title, :description)
  end
end
