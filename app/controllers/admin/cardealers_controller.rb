class Admin::CardealersController < ApplicationController
  before_action :require_admin
  before_action :set_cardealer, only: [:show, :inquiries_today, :inquiries_this_week, :inquiries_this_month, :inquiries_all, :staffs_index, :models_index, :filtered_models, :model_request, :create_model_request]

  def index
    # Hiển thị danh sách các cardealer cho admin
    @cardealers = Cardealer.all
  end

  def show
    # Hiển thị thông tin chi tiết của một cardealer
    # và các inquiries liên quan
    @inquiries = @cardealer.inquiries.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def inquiries_today
    @inquiries = @cardealer.inquiries.where('inquiries.created_at >= ?', Time.zone.now.beginning_of_day).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    render :show
  end

  def inquiries_this_week
    @inquiries = @cardealer.inquiries.where('inquiries.created_at >= ?', Time.zone.now.beginning_of_week).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    render :show
  end

  def inquiries_this_month
    @inquiries = @cardealer.inquiries.where('inquiries.created_at >= ?', Time.zone.now.beginning_of_month).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    render :show
  end

  def inquiries_all
    @inquiries = @cardealer.inquiries.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    render :show
  end

  def staffs_index
    @staffs = @cardealer.car_dealer_employees
  end

  def model_request
    @model_request = ModelRequest.new
  
  end

  def models_index
    @brands = Brand.all
    @car_models = @cardealer.car_dealer_cars
    @model_brands = @car_models.map(&:model_brand).uniq
  end

  def filtered_models
    brand = params[:brand]
    if brand.blank?
      @car_models = @cardealer.car_dealer_cars
    else
      @car_models = @cardealer.car_dealer_cars.joins(:model).where(models: { model_brand: brand })
    end
    respond_to do |format|
      format.js { render partial: 'model_list', locals: { cars: @car_models } }
    end
  end

  def create_model_request
    @model_request = ModelRequest.new(model_request_params)
    @model_request.cardealer = @cardealer
  
    if @model_request.save
      redirect_to admin_cardealer_path(@cardealer), notice: 'Yêu cầu đã được gửi thành công.'
    else
      render :model_request
    end
  end

  private

  def set_cardealer
    @cardealer = Cardealer.find(params[:id])
  end

  def require_admin
    unless current_user&.admin_car_dealer? && current_user.cardealer_id == params[:id].to_i
      flash[:alert] = "Bạn không được phép truy cập phần này."
      redirect_to car_show_path
    end
  end

  def model_request_params
    params.require(:model_request).permit(:brand_name, :car_model_name, :model_year)
  end
end
