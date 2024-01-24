class ModelsController < ApplicationController
  def show
    @model = Model.find(params[:id])
    @brand_models = @model.brand.models.where.not(id: @model.id)
    @segment_models = @model.segment.models.where.not(id: @model.id)  
  end
end
