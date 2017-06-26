class SubsController < ApplicationController
  before_action :require_moderator, only: [:edit, :update]
  before_action :require_logged_in, except: [:index, :show]

  def new
    render :new
  end

  def create
    @thread = Sub.new(sub_params)
    @thread.moderator_id = current_user.id
    if @thread.save
      redirect_to sub_url(@thread)
    else
      flash[:errors]=@thread.errors.full_messages
      redirect_to new_sub_url
    end
  end

  def update
    @thread = Sub.find(params[:id])
    if @thread.update_attributes(sub_params)
      redirect_to sub_url(@thread)
    else
      flash[:errors] = @thread.errors.full_messages
      render :update
    end
  end

  def show
    @thread = Sub.find(params[:id])
    if @thread
      # redirect_to sub_url(@thread)
      render :show
    else
      flash[:errors]=@thread.errors.full_messages
      redirect_to new_sub_url
    end
  end

  def index
    @threads = Sub.all
    render :index
  end

  def edit
    @thread = Sub.find_by(id: params[:id])
    render :edit
  end


  private

  def sub_params
    params.require(:sub).permit(:title, :description, :moderator)
  end

  def require_moderator
    @thread = Sub.find_by(id: params[:id])
    redirect_to sub_url(@thread) unless current_user.id == @thread.moderator_id
  end

end
