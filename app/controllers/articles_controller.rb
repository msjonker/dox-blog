class ArticlesController < ApplicationController
  before_action :load_article, only: :show

  def index
    @featured_article = Article.featured.limit(1).first
    @articles = Article.published.where.not(id: @featured_article).
      paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def search
    @articles = Article.search(Article.published, [:title, :body], params[:query])
      .paginate(page: params[:page], per_page: 5)
  end
end
