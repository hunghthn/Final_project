class ReviewsController < ApplicationController
    before_action :require_login
    before_action :set_model, only: [:create]
  
    def create
      @review = @model.reviews.build(review_params)
      @review.user = current_user
  
      if @review.save
        flash[:notice] = 'Đánh giá của bạn đã được gửi thành công.'
        redirect_to request.referer
      else
        flash[:alert] = 'Có lỗi xảy ra khi gửi đánh giá của bạn.'
        redirect_to request.referer
      end
    end
  
    private
  
    def set_model
      @model = Model.find(params[:model_id])
    end
  
    def review_params
      params.require(:review).permit(:content, :model_id, :user_id)
    end
  
    def require_login
      unless current_user
        flash[:alert] = 'Bạn cần phải đăng nhập để thực hiện hành động này.'
        redirect_to login_path
      end
    end
  end
  