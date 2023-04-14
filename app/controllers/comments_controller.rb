class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show update destroy]

  # GET /comments get all comments for a post
  def index
    @comments = Comment.where(post_id: params[:post_id])
    render json: @comments
  end

  # POST /comments create a comment for a post by a user
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1 update a comment for a post by a user
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1 delete a comment for a post by a user
  def destroy
    @comment.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id)
  end
end
