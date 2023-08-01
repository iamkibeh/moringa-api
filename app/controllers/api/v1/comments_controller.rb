class  Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /comments get all comments for a post
  def index
    @post = Post.find_by!(id: params[:post_id])
    @comments = Comment.where(post_id: params[:post_id])
    if @post
      render json: @comments, status: :ok
    else
      throw ActiveRecord::RecordNotFound
    end
  end

  # get /comments/:id get a comment for a post by a user
  def show
    @comment = Comment.find_by!(id: params[:id])
    render json: @comment, status: :ok
  end

  # POST /comments create a comment for a post by a user
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
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
    if @comment.user_id == current_user.id
      @comment.destroy 
      render json: { message: "Comment deleted successfully" }, status: :ok
    else
      render json: { error: "You cannot delete other user's comment" }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def render_not_found_response e
    render json: { error: e }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.permit(:comment, :post_id, :user_id, :parent_comment_id)
  end
end
