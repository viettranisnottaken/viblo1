class RequestsController < ApplicationController
  def index
    @requests = Request.all
  end

  def new
    redirect_to root_path if current_user.requests.find_by status: nil
    @request = Request.new
  end

  def create
    current_user.requests.create!
    current_user.update_attribute(:requested, "pending")
    respond_to do |format|
      format.html {redirect_to "/requests"}
      format.json
    end
  end
  
  def update
    request = Request.find(params[:id])
    request.update_attributes reason: params[:request][:reason], status: params[:request_status]
    if request.status
      request.user.update_attribute(:kind, "seller")
      redirect_to action: :index
    else
      request.update_attribute(:unread, true)
      redirect_to action: :index
    end
    # request.user.update_attribute(:requested, params[:requested])
    # if request.user.requested == "accepted"
    #   request.user.update_attribute(:kind, "seller")
    #   request.delete
    # elsif request.user.requested == "rejected"
    #   request.update_attribute(:reason, params[:request][:reason])
    #   request.update_attribute(:unread, true)
    #   r
    # end
  end

  private

  # def request_params
  #   params.require(:request).permit(:reason)
  # end
end
