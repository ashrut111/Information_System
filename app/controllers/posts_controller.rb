class PostsController < ApplicationController
  before_action :post_of_current_user, only: [:show, :edit, :update, :destroy]
  layout "post_layout", only: :index
  layout "new_post_layout", only: [:new, :show, :edit]
  
  def index
    @posts = current_user.posts.with_attached_images
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.create(post_params)
    @post.user_id = current_user.id
    @post.images.attach(params[:post][:images])
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @post.images.attach(params[:post][:image])
    @post.update(post_params)
    redirect_to posts_path, notice: "Post Updated Successfully.."
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end
  
  private

  def post_of_current_user
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
