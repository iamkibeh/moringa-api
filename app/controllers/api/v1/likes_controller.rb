class  Api::V1::LikesController < ApplicationController
  before_action :set_like, only: %i[destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  # List all likes for a post (GET /posts/:id/likes)
  def index
    @post = Post.find_by!(id: params[:post_id])
    @likes = Like.where(post_id: params[:post_id])
    if @post
      render json: @likes
    else
      throw ActiveRecord::RecordNotFound
    end
  end

  # POST /likes create a like for a post by a user
  def create
    @like = Like.new()
    @like.user_id = current_user.id
    @like.post_id = params[:post_id]
    if @like.save
      @like.post.increment!(:post_likes)
      render json: @like, status: :created, location: api_v1_post_likes_url(@like)
    else
      render json: @like.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  def destroy
    if @like.destroy
      @like.post.decrement!(:post_likes)
      head :no_content
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find_by!(user_id: current_user.id)
  end

  def record_invalid
    render json: { error: "You cannot unlike more than once" }, status: :not_found
  end

  def rescue_from_not_found_response e
    render json: {  error: e }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def like_params
    params.permit(:post_id, :user_id)
  end
end
