class CarDealerEmployeesController < ApplicationController
    before_action :set_car_dealer_employee, only: [:update, :destroy]
    
    def create
      @car_dealer_employee = CarDealerEmployee.new(car_dealer_employee_params)
      if @car_dealer_employee.save
        flash[:notice] = "Nhân viên đã được tạo thành công."
        redirect_to request.referer
      else
        flash[:alert] = "Đã xảy ra lỗi khi tạo nhân viên."
        redirect_to request.referer
      end
    end

    def update
        # binding.pry
      if @car_dealer_employee.update(car_dealer_employee_params)
        flash[:notice] = "Thay đổi thông tin thành công."
        redirect_to request.referer
      else
        flash[:alert] = "Đã xảy ra lỗi khi thay đổi thông tin."
        redirect_to request.referer
      end
    end

    def destroy
        if @car_dealer_employee.destroy
          flash[:notice] = "Người dùng đã được xóa thành công."
        else
          flash[:alert] = "Đã xảy ra lỗi khi xóa người dùng."
        end
        redirect_to request.referer
    end
    
    private
    
    def set_car_dealer_employee
      @car_dealer_employee = CarDealerEmployee.find(params[:id])
    end
    
    def car_dealer_employee_params
        role = params[:car_dealer_employee][:role]

        # Chuyển role sang số nguyên nếu có thể chuyển đổi, nếu không thì giữ nguyên
        role = role.to_i.to_s == role ? role.to_i : role
      
        # Trả về params đã được permit, với role đã được chuyển đổi
        params.require(:car_dealer_employee).permit(:name, :role, :gender, :detail, :cardealer_id).merge(role: role)
    end
  end
  