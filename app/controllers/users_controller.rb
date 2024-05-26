class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # Convert gender to integer
    user_params[:gender] = user_params[:gender].to_i

    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Người dùng đã tạo thành công."
      redirect_to @user
    else
      flash[:alert] = "Đã xảy ra lỗi khi tạo người dùng."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :password, :password_confirmation, :email, :phone, :gender).tap do |user_params|
      user_params[:gender] = user_params[:gender].to_i if user_params[:gender].present?
    end
  end
end
