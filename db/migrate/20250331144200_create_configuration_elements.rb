class CreateConfigurationElements < ActiveRecord::Migration[7.0]
  def change
    create_table :configuration_elements do |t|
      t.integer :element_type, null: false
      t.integer :x_position
      t.integer :y_position
      t.integer :width
      t.integer :height
      t.string :label
      t.integer :control_function
      t.integer :target_type, null: false
      t.integer :target_id

      t.timestamps
    end
  end
end
