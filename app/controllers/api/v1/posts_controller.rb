class  Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # GET /posts
  def index
    @posts = Post.all
    render json: @posts
  end

  # GET /posts/1
  def show
    # include image url in a post
    render json: @post, include: :images
  end

  # POST /posts
  def create
    @post = Post.new(post_params.except(:images))
    @post.user_id = current_user.id
    images = params[:post][:images]
    images.each { |image| @post.images.attach(image) } if images
    @post.save!
    render json: @post, status: :created
  end

  # PATCH/PUT /posts/1
  def update
    @post.update!(post_params)
      render json: @post, status: :ok
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(
      :post_title,
      :post_description,
      :post_like,
      :post_category,
      :post_comment,
      :post_type,
      :user_id,
      images: []
    )
  end

  def render_not_found_response
    render json: { error: "Post not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
