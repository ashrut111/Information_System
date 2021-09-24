class PostsController < ApplicationController
  before_action :post_of_current_user, only: [:show, :edit, :update, :destroy]
  layout "post_layout", only: :index
  layout "show_post_layout", only: :show
  layout "new_post_layout", only: [:new, :edit]
  
  def index
    @posts = current_user.posts
  end

  def new
    @post = current_user.posts.new
  end
  
  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post was successfully created..."
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @post.update(post_params)
    unless @post.image.attached?
      @post.image.attach(params[:post][:image])
    end
    if true
      redirect_to post_path(@post.id), notice: "Post Updated Successfully..."
    else
      render :edit
    end
  end

  def destroy
    @post.image.purge
    @post.destroy
    if @post.destroyed?
      redirect_to posts_path, notice: "Post Deleted Successfully"
    else
      render :show, alert: "Unable to Destroy"  
    end
  end
  
  private
  
  def post_of_current_user
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
