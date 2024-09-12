# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  # skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  skip_before_action :verify_authenticity_token

  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      PostDeletionJob.set(wait_until: 24.hours.from_now).perform_later(@post.id)
      render json: { post: @post, notice: "Post was successfully created." }, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
    authorize_user
  end

  def update
    # authorize_user
    if @post.update(post_params)
      render json: { post: @post, notice: "Post was successfully updated." }, status: :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    # authorize_user
    @post.destroy
    render json: { notice: "Post was successfully destroyed." }, status: :ok
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :tags, :author_id)
  end

  def authorize_user
    render json: { alert: "Not authorized" }, status: :forbidden unless @post.author == current_user
  end
end
