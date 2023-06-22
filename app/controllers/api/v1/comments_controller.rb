class  Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /comments get all comments for a post
  def index
    @comments = Comment.where(post_id: params[:id])
    render json: @comments, status: :ok
  end

  # get /comments/:id get a comment for a post by a user
  def show
    @comments = Comment.where(post_id: params[:id])
    @comment = @comments.find_by!(id: params[:comment_id])
    render json: @comment, status: :ok
  end

  # POST /comments create a comment for a post by a user
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:id]
    @comment.parent_comment_id = params[:comment_id] if params[:comment_id]
    if @comment.save
      render json: @comment, status: :created
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

  def render_not_found_response
    render json: { error: "Comment not found" }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.permit(:comment, :post_id, :user_id, :parent_comment_id)
  end
end
