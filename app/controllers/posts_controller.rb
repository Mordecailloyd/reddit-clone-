class PostsController < ApplicationController
  before_action :require_author, only: [:edit, :update]
  before_action :require_logged_in, except: [:index, :show]

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to new_post_url
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to subs_url
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post
      @post.destroy
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to post_url(@post)
    end
  end

  def show
    @post = Post.find(params[:id])
    if @post
      render :show
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to new_post_url
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    render :edit
  end

  def new
    render :new
  end

  private
  def post_params
    params.require(:post).permit(:title, :sub_id, :content, :url)
  end


  def require_author
    @post = Post.find_by(id: params[:id])
    redirect_to post_url(@post) unless current_user.id == @post.author_id
  end
end
