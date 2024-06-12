class InquiryMailer < ApplicationMailer

    default from: 'carvietnam01@gmail.com'

    def send_otp(email, otp)
      @otp = otp
      mail(to: email, subject: 'Mã OTP từ CARVN')
    end
end
  