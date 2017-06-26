class SessionsController < ApplicationController

  before_action :require_logged_in, only: [:destroy]
  before_action :require_logged_out, only: [:create, :new]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user.nil?
      flash[:errors] = ["Invalid username or password"]
    else
      login!(user)
      redirect_to posts_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
