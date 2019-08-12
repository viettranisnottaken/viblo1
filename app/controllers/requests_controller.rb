class RequestsController < ApplicationController
  def index
    @requests = Request.all
  end
  def new
    @request = Request.new
  end
  def create
    current_user.requests.create!
    current_user.update_attribute(:requested, "pending")
    respond_to do |format|
      format.html {redirect_to requests_path}
      format.json
    end
  end
  def update
    request = Request.find(params[:id])
    user = request.user
    request.user.update_attribute(:requested, params[:requested])
    if request.user.requested == "accepted"
      request.user.update_attribute(:kind, "seller")
      request.delete
      redirect_to action: :index
    elsif request.user.requested == "not_yet_rejected"
      request.delete
      redirect_to edit_user_path
    end
  end
end
