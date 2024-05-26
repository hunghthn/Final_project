class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      log_in user
      flash[:notice] = "Đăng nhập thành công."
      redirect_to car_show_path
    else
      flash.now[:alert] = "Tên tài khoản hoặc mật khẩu không đúng."
      render 'new'
    end
  end
  

  def destroy
    log_out
    flash[:notice] = "Đăng xuất thành công."
    redirect_to car_show_path
  end
end
