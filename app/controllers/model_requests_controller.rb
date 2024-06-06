class ModelRequestsController < ApplicationController
    def new
      @model_request = ModelRequest.new
      @cardealer = Cardealer.find(params[:cardealer_id])
    end
  
    def create
      @model_request = ModelRequest.new(model_request_params)
      @model_request.cardealer_id = params[:model_request][:cardealer_id]
  
      if @model_request.save
        flash[:notice] = "Yêu cầu đã được gửi thành công."
        redirect_to request.referer
      else
        render :new
        flash[:alert] = 'Có lỗi xảy ra khi gửi.'
      end
    end
  
    private
  
    def model_request_params
      params.require(:model_request).permit(:brand_name, :model_name, :model_year, :cardealer_id)
    end
  end
  