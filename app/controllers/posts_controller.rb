class PostsController < ApplicationController
  def index
    page = params[:page] || 1
    @posts = self.get_page(page)
    render :index
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    @post.update(title: params[:title],
    content: params[:content],
    written_at: DateTime.now)
    redirect_to posts_path
  end

  def new
    render :new
  end

  def create
    tags = params[:tags].split(", ")
    tag_models = tags.map { |tag| Tag.find_or_create_by(name: tag) }
    @post = Post.create(title: params[:title],
                        content: params[:content],
                        written_at: DateTime.now,
                        tags: tag_models)
    redirect_to posts_path
  end

  protected
  def get_page(n)
    page_offset = (n - 1) * 10
    Post.order(written_at: :desc).offset(page_offset).limit(10)
  end
end
