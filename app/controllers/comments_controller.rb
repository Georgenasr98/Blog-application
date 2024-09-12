class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]
  # skip_before_action :authenticate_request, only: [ :index ] # If you want to skip authentication for listing comments

  # GET /comments
  def index
    @comments = Comment.all
    render json: @comments
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    # Optionally, you can set the author here if needed
    # @comment.author = current_user
    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/:id
  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /comments/:id
  def destroy
    @comment.destroy
    render json: { notice: "Comment was successfully deleted." }, status: :ok
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id, :author_id) # Adjust as needed
  end
end
