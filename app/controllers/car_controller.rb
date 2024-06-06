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

    @models = @q.result(distinct: true).order(:model_title_name).paginate(page: params[:page], per_page: 9)
    @models_count = @models.total_entries
    @selected_sort_option = params[:sort_option]
    @min_price = params[:min_price]
    @max_price = params[:max_price]
  end

  def models_autocomplete
    term = params[:q]
    models = Model.where('model_title_name ILIKE ?', "%#{term}%").pluck(:model_title_name)
    
  end
  
  def add_to_compare
    model_id = params[:model_id].to_i
  
    session[:compared_models] ||= []
  
    if session[:compared_models].include?(model_id)
      render json: { success: false, error: 'Model already in comparison' }, status: :unprocessable_entity
    elsif session[:compared_models].size >= 3
      render json: { success: false, error: 'Cannot compare more than 4 models' }, status: :unprocessable_entity
    else
      session[:compared_models] << model_id
      render json: { success: true, compared_models: session[:compared_models] }
    end
  end

  def remove_from_compare
    model_id = params[:model_id].to_i
    session[:compared_models].delete(model_id)
    render json: { success: true, compared_models: session[:compared_models] }
  end

  def render_compared_models
    respond_to do |format|
      format.js
    end
  end  

  def reset_compare
    reset_session
    redirect_to car_show_path
  end
  
  private

  def apply_sort_condition(sort_option)
    case sort_option
    when 'lowest_price'
      @q.sorts = 'model_price_min asc'
    when 'highest_price'
      @q.sorts = 'model_price_min desc'
    when 'name_a_to_z'
      @q.sorts = 'model_title_name asc'
    when 'name_z_to_a'
      @q.sorts = 'model_title_name desc'
    end
  end

  def apply_price_condition(min_price, max_price)
    @q.model_price_min_gteq = min_price.to_i * 1000 if min_price.present?
    @q.model_price_min_lteq = max_price.to_i * 1000 if max_price.present?
  end
end
