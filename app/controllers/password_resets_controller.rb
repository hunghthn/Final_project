class PasswordResetsController < ApplicationController
    def new
    end
  
    def create
      @user = User.find_by(email: params[:email])
      if @user
        new_password = SecureRandom.urlsafe_base64(8)
        @user.update(password: new_password, password_confirmation: new_password)
        UserMailer.password_reset(@user, new_password).deliver_now
        flash[:notice] = "Email đã được gửi với mật khẩu mới."
        redirect_to login_path
      else
        flash.now[:alert] = "Email không tồn tại trong hệ thống."
        render :new
      end
    end
  end
  