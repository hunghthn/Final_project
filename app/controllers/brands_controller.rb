class BrandsController < ApplicationController
  # Phương thức để lấy danh sách các quận/huyện theo tỉnh/thành phố
  def index
    @models = Model.where(brand_id: params[:brand_id])
    render json: @models
  end
end
