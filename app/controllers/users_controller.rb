class UsersController < ApplicationController
  def new
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
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    request = Request.find(params[:id])
    @user = request.user
    if @user.update_attribute(:reason, params[:user][:reason])
      @user.update_attribute(:requested, "rejected")
      redirect_to @user
      request.delete
      flash[:success] = "done"
    else
      redirect_to requests_path
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
