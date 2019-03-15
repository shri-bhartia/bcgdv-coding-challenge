class CreateTimeModels < ActiveRecord::Migration[5.0]
  def change
    create_table :time_models do |t|
      t.integer :line_id
      t.integer :stop_id
      t.time :time

      t.timestamps
    end
  end
end
