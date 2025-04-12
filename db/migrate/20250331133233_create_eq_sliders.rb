class CreateEqSliders < ActiveRecord::Migration[7.0]
  def change
    create_table :eq_sliders do |t|
      t.integer :element_id
      t.integer :frequency_band
      t.integer :default_value
      t.integer :value
      t.integer :min_value
      t.integer :max_value

      t.timestamps
    end
  end
end
