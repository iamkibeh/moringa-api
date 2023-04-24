class LikesController < ApplicationController
  before_action :set_like, only: %i[destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # List all likes for a post (GET /posts/:id/likes)
  def index
    # @post = Post.find_by(id: params[:id])
    # @likes = @post.post_like
    @likes = Like.where(post_id: params[:id])
    render json: @likes
  end

  # POST /likes create a like for a post by a user
  def create
    @like = Like.new()
    @like.user_id = current_user.id
    @like.post_id = params[:id]
    if @like.save
      # render json: @like, status: :created, location: @like
      # Redirect to the appropriate path after a successful save
      # increment the like count for the associated post.
      # @like.post.update(likes_count: @like.post.likes.count)
      @like.post.increment!(:post_likes)
      redirect_to post_path(@like.post_id), notice: "Like created successfully."
    else
      render json: @like.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  def destroy
    if @like.destroy
      # decrement the like count for the associated post.
      @like.post.decrement!(:post_likes)
      head :no_content
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find_by!(user_id: params[:user_id])
  end

  def render_not_found_response
    render json: {
             error: "You cannot unlike more than once"
           },
           status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def like_params
    params.permit(:post_id, :user_id)
  end
end
