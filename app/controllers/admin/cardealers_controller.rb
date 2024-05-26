class Admin::CardealersController < ApplicationController
  before_action :set_cardealer, only: [:show, :inquiries_today, :inquiries_this_week, :inquiries_this_month, :inquiries_all, :staffs_index, :models_index, :filtered_models]

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

  def models_index
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

  private

  def set_cardealer
    @cardealer = Cardealer.find(params[:id])
  end
end
