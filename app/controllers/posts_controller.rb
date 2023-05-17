class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

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

    # debugger
    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
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
      # :post_img,
      :post_like,
      :post_category,
      :post_comment,
      :post_type,
      :user_id,
      images: []
    )
  end
end
