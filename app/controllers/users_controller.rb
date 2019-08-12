class UsersController < ApplicationController
  def new
    unless logged_in?
      redirect_to login_path
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
      flash[:success] = "done"
    else
      render :new
      flash[:danger] = "ngu"
    end

  end

  def show
    @user = User.find(params[:id])
    @request = current_user.requests.find_by unread:true
    if @request
      @request.update_attribute(:unread, false)
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:user_id])
    if @user.update_attribute(:kind, "seller")
      redirect_to @user
      flash[:success] = "done"
    else
      redirect_to requests
      flash[:danger] = "not done"
    end
  end

  def index
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
