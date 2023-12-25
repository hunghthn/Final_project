class CarController < ApplicationController
  def show
    @brands = Brand.order(:brand_name).all
    @types = Type.order(:type_name).all
    @segments = Segment.order(:segment_name).all

    # Sử dụng Ransack để tạo đối tượng tìm kiếm
    @q = Model.ransack(params[:q])

    # Áp dụng điều kiện sắp xếp từ người dùng nếu có
    apply_sort_condition(params[:sort_option])

    # Áp dụng điều kiện giá nếu có
    apply_price_condition(params[:min_price], params[:max_price])

    @models = @q.result(distinct: true).paginate(page: params[:page], per_page: 9)
    @models_count = @models.total_entries
  end

  private

  def apply_sort_condition(sort_option)
    case sort_option
    when 'lowest_price'
      @q.sorts = 'model_price_min asc'
    when 'highest_price'
      @q.sorts = 'model_price_max desc'
    when 'name_a_to_z'
      @q.sorts = 'model_title_name asc'
    when 'name_z_to_a'
      @q.sorts = 'model_title_name desc'
    end
  end

  def apply_price_condition(min_price, max_price)
    @q.model_price_min_gteq = min_price.to_i * 1000 if min_price.present?
    @q.model_price_max_lteq = max_price.to_i * 1000 if max_price.present?
  end
end
