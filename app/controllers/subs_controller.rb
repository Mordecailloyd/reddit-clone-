class SubsController < ApplicationController
  before_action require_moderator, only: [:edit, :update]

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

  end

  def show
    @thread = Sub.find_by(id:params[:id])
    if @thread
      render
    else
      render
    end
  end

  def index

  end

  def edit

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
