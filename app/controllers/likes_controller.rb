class LikesController < ApplicationController
  before_action :set_like, only: %i[destroy]

  # POST /likes create a like for a post by a user
  def create
    @like = Like.new(like_params)
    # @like.user_id = current_user.id
    # @like.post_id = params[:post_id]
    if @like.save
      render json: @like, status: :created, location: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  def destroy
    if @like.destroy
      head :no_content
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find_by(user_id: params[:user_id])
  end

  # Only allow a list of trusted parameters through.
  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end
end
