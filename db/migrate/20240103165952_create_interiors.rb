class CreateInteriors < ActiveRecord::Migration[7.1]
  def change
    create_table :interiors do |t|

      t.timestamps
    end
  end
end
