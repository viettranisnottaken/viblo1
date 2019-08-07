class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = "You can buy now"
    else
      render :new
      flash[:danger] = "something went wrong"
    end

  end

  def show
    @user = User.find(params[:id])
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
    if @user.update_attribute(:kind, "buyer")
      flash[:success] = "do you want to go back"
    end
  end

  def index
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'pls log in first'
      redirect_to login_url
    end
  end
end
