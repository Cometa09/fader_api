class CreateMeters < ActiveRecord::Migration[7.0]
  def change
    create_table :meters do |t|
      t.references :element, null: false, foreign_key: true
      t.string :meter_type
      t.integer :current_level
      t.integer :peak_level

      t.timestamps
    end
  end
end
