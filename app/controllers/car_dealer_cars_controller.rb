class CarDealerCarsController < ApplicationController
    before_action :set_car_dealer_car, only: [ :update, :destroy]

    def create
      # binding.pry
      @car_dealer_car = CarDealerCar.new(car_dealer_car_params)
      if @car_dealer_car.save
        flash[:notice] = "Mẫu xe đã được tạo thành công."
        redirect_to request.referer
      else
        flash[:alert] = "Đã xảy ra lỗi khi tạo mẫu xe."
        redirect_to request.referer
      end
    end

    def update
      if @car_dealer_car.update(car_dealer_car_params)
        flash[:notice] = "Thông tin xe đã được cập nhật thành công."
        redirect_to request.referer
      else
        flash[:alert] = "Đã xảy ra lỗi khi cập nhật thông tin xe."
        redirect_to request.referer
      end
    end

    def destroy
        if @car_dealer_car.destroy
          flash[:notice] = "Mẫu xe đã được xóa thành công."
        else
          flash[:alert] = "Đã xảy ra lỗi khi xóa mẫu xe."
        end
        redirect_to request.referer
    end
  
    private
  
    def set_car_dealer_car
      @car_dealer_car = CarDealerCar.find(params[:id])
    end

    def format_price(price)
        billions = price / 1000
        millions = price % 1000
    
        if billions > 0 && millions > 0
          "#{billions} tỷ #{millions} triệu".strip
        elsif billions > 0
          "#{billions} tỷ"
        else
          "#{millions} triệu"
        end
    end
  
    def car_dealer_car_params
      cardealer_price = params[:car_dealer_car][:cardealer_price]
      params[:car_dealer_car][:cardealer_price] = format_price(params[:car_dealer_car][:cardealer_price].to_i)
      params.require(:car_dealer_car).permit(:amount, :cardealer_price, :cardealer_id, :model_id)
    end
  end
  