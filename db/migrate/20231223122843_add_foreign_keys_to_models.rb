# frozen_string_literal: true

class AddForeignKeysToModels < ActiveRecord::Migration[7.1]
  def change
    add_reference :models, :brand, foreign_key: true
    add_reference :models, :type, foreign_key: true
    add_reference :models, :segment, foreign_key: true
  end
end
