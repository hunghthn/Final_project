class InquiriesController < ApplicationController
    def create
      @inquiry = Inquiry.new(inquiry_params)
      if @inquiry.save
        flash[:notice] = "Yêu cầu được tạo thành công."
        redirect_to request.referer
      else
        flash[:alert] = "Đã xảy ra lỗi khi tạo yêu cầu."
        redirect_to request.referer
      end
    end
  
    private
  
    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :phone, :note, :preferred_contact, :car_dealer_car_id ,:user_id)
    end
  end
  