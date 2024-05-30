class UsersController < ApplicationController

  before_action :require_login , only: [:show, :update]
  before_action :correct_user, only: [:show, :update]

  def new
    @user = User.new
  end

  def create
    # Convert gender to integer
    user_params[:gender] = user_params[:gender].to_i

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

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :password, :password_confirmation, :email, :phone, :gender).tap do |user_params|
      user_params[:gender] = user_params[:gender].to_i if user_params[:gender].present?
    end
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
