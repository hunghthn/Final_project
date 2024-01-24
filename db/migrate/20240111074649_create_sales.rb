class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.string :year
      t.string :month
      t.string :model_number
      t.string :total_sales
      t.string :northern_sales
      t.string :central_sales
      t.string :southern_sales
      t.references :model, foreign_key: true
      t.timestamps
    end
  end
end
