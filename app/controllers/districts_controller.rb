class DistrictsController < ApplicationController
  # Phương thức để lấy danh sách các quận/huyện theo tỉnh/thành phố
  def index
    @districts = District.where(prefecture_id: params[:prefecture_id])
    render json: @districts
  end
end
