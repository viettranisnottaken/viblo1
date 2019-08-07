class RequestsController < ApplicationController
  def index
    @requests = Request.all
  end

  def new
    @request = Request.new
  end

  def create
    current_user.requests.create!
    respond_to do |format|
      if current_user.admin || current_user.kind == "buyer"
        format.html {redirect_to admin_requests_path}
      else
        format.html {redirect_to root_path}
        format.json
      end
    end
  end

  def update
    if @request.update_attributes request_params
      @user.update_attribute(:kind, "seller") if request.accept
      redirect_to @user
      flash[:success] = "done"
    else
      redirect_to requests
      flash[:danger] = "not done"
    end
  end
end
