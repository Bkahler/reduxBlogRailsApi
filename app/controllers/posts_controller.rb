class PostsController < ApplicationController
    protect_from_forgery with: :null_session
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  def index
    @posts = Post.all
    render json: @posts, :except => [:created_at, :updated_at]
  end

  def show
    @post = set_post
    render json: @post, :except => [:created_at, :updated_at]
  end

  def create
    @post = Post.create(post_params)
    render json: @post, :except => [:created_at, :updated_at]
  end

  def edit
    @post = set_post
    render json: @post, :except => [:created_at, :updated_at]
  end

  def destroy
    @post = set_post
    @post.destroy
    render json: @post, :except => [:created_at, :updated_at]
  end


private
  def post_params
    params.require(:post).permit(:title, :category, :content)
  end

  def set_post
    Post.find(params[:id])
  end

  def not_found
    render json: '{"status":"404","error": "not_found"}'
  end

end
