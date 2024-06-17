class UserMailer < ApplicationMailer
    default from: 'carvietnam01@gmail.com'

    def password_reset(user, new_password)
      @user = user
      @new_password = new_password
      mail(to: @user.email, subject: "Reset mật khẩu CarVN")
    end
  end
  