
class CardealersController < ApplicationController
  before_action :set_cardealer, only: [:show, :filtered_models]

  def index
    @cardealers = Cardealer.all
  end

  def show
    @employees = @cardealer.car_dealer_employees
    @cars = @cardealer.car_dealer_cars
    @model_brands = @cars.map(&:model_brand).uniq
    @amount = @cars.sum(:amount)
    @models = @cars
  end

  def find_by_district
    district_name = params[:district_name]
    model_id = params[:model_id]
    @model = Model.find_by(id: model_id)
    @cardealers = Cardealer.joins(:district).where("districts.name = ?", district_name)
    @car_dealer_cars = CarDealerCar.where(model_id: @model.id, cardealer_id: @cardealers.pluck(:id))
    if @car_dealer_cars.empty?
      # binding.pry
      district = District.find_by(name: district_name)
      prefecture_id = district.prefecture_id
      cardealers_in_prefecture = Cardealer.joins(:district).where(districts: { prefecture_id: prefecture_id })
      # Lấy tất cả CarDealerCar liên kết với các Cardealer đó
      @car_dealer_cars = CarDealerCar.where(model_id: @model.id, cardealer_id: cardealers_in_prefecture.pluck(:id))
      if @car_dealer_cars.empty?
        @car_dealer_cars = CarDealerCar.where(model_id: @model.id)
      end
    end
    render partial: 'models/cardealer_info', locals: { car_dealer_cars: @car_dealer_cars }
  end

  def filtered_models
    brand = params[:brand]
    if brand.blank?
      @car_models = @cardealer.car_dealer_cars
    else
      @car_models = @cardealer.car_dealer_cars.joins(:model).where(models: { model_brand: brand })
    end
    respond_to do |format|
      format.js { render partial: 'car_list', locals: { models: @car_models } }
    end
  end

  private

  def set_cardealer
    @cardealer = Cardealer.find(params[:id])
  end

end
