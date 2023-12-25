# frozen_string_literal: true

class AddModelPriceToModels < ActiveRecord::Migration[7.1]
  def change
    add_column :models, :model_price_min, :integer
    add_column :models, :model_price_max, :integer
  end
end
