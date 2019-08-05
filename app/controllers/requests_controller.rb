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
      format.html {redirect_to requests_path}
      format.json
    end
  end
end
