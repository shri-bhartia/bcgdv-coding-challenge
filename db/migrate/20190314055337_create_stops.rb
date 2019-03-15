class CreateStops < ActiveRecord::Migration[5.0]
  def change
    create_table :stops do |t|
      t.integer :x_coordinate
      t.integer :y_coordinate

      t.timestamps
    end
  end
end
