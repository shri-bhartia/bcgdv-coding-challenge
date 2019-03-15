class CreateDelays < ActiveRecord::Migration[5.0]
  def change
    create_table :delays do |t|
      t.string :line_name
      t.integer :delay

      t.timestamps
    end
  end
end
