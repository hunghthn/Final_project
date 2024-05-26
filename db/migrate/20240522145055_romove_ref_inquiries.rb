class RomoveRefInquiries < ActiveRecord::Migration[7.1]
  def change
    remove_column :inquiries, :model_id
    remove_column :inquiries, :cardealer_id
  end
end
