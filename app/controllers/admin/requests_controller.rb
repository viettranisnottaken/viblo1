class Admin::RequestsController < ApplicationController

	def index
		@requests = Request.where(status:nil)
	end

	def edit
	end

	def update
		@request = Request.find(params[:id])
		@request.update_attribute(:status, params[:status])
		if @request.status
			@request.user.update_attribute(:kind, "seller")
			redirect_to action: :index
		else
			redirect_to action: :index
		end
	end
end
