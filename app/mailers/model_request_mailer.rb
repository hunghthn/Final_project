class ModelRequestMailer < ApplicationMailer
    default from: 'carvietnam01@gmail.com'
  
    def daily_report(model_requests, email)
      @model_requests = model_requests
      mail(to: email, subject: 'Báo cáo yêu cầu mẫu xe mới hàng ngày')
    end
  end
  