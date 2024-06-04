class UsersController < ApplicationController

  before_action :require_login , only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create

    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Người dùng đã tạo thành công."
      redirect_to car_show_path
    else
      flash[:alert] = "Đã xảy ra lỗi khi tạo người dùng."
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Thông tin người dùng đã được cập nhật thành công."
      redirect_to user_path(@user)
    else
      flash[:alert] = "Đã xảy ra lỗi khi cập nhật thông tin người dùng."
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @inquiries = @user.inquiries.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def edit_password
    @user = current_user
  end
  
  def update_password
    @user = current_user
    if @user&.authenticate(params[:user][:current_password])
      if @user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
        flash[:notice] = "Mật khẩu đã được cập nhật thành công."
        redirect_to user_path(current_user)
      else
        flash.now[:alert] = "Xác nhận mật khẩu mới không khớp."
        render :edit_password
      end
    else
      flash.now[:alert] = "Mật khẩu hiện tại không đúng."
      render :edit_password
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :password, :password_confirmation, :email, :phone, :gender)
  end

  def require_login
    unless current_user
      flash[:alert] = "Bạn cần phải đăng nhập để truy cập trang này."
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:alert] = "Bạn không được phép truy cập trang này."
      redirect_to car_show_path
    end
  end

end
