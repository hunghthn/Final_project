# class InquiriesController < ApplicationController
#     def create
#       @inquiry = Inquiry.new(inquiry_params)
#       if @inquiry.save
#         flash[:notice] = "Yêu cầu được tạo thành công."
#         redirect_to request.referer
#       else
#         flash[:alert] = "Đã xảy ra lỗi khi tạo yêu cầu."
#         redirect_to request.referer
#       end
#     end
  
#     private
  
#     def inquiry_params
#       params.require(:inquiry).permit(:name, :email, :phone, :note, :preferred_contact, :car_dealer_car_id ,:user_id)
#     end
#   end
  
class InquiriesController < ApplicationController
  def create
    @inquiry = Inquiry.new(inquiry_params)
    if session[:otp_code] == params[:otp_code]
      if @inquiry.save
        flash[:notice] = "Yêu cầu được tạo thành công."
        session.delete(:otp_code)  # Xóa mã OTP sau khi xác thực thành công
        redirect_to request.referer
      else
        flash[:alert] = "Đã xảy ra lỗi khi tạo yêu cầu."
        redirect_to request.referer
      end
    else
      flash[:alert] = "Mã OTP không hợp lệ."
      redirect_to request.referer
    end
  end

  def send_otp
    email = params[:email]
    otp = SecureRandom.hex(3)
    session[:otp_code] = otp
    InquiryMailer.send_otp(email, otp).deliver_now
    head :ok
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :phone, :note, :preferred_contact, :car_dealer_car_id, :user_id)
  end
end
