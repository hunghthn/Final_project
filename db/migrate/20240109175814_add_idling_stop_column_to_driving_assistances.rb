class AddIdlingStopColumnToDrivingAssistances < ActiveRecord::Migration[7.1]
  def change
    add_column :driving_assistances, :idling_stop, :string
  end
end
