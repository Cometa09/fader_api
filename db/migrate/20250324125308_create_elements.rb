class CreateElements < ActiveRecord::Migration[7.0]
  def change
    create_table :elements do |t|
      t.integer :element_type, default: 0, null: false  # Default 0, тип по умолчанию может быть 'Button'
      t.integer :x_position
      t.integer :y_position
      t.integer :width
      t.integer :height
      t.string :label
      t.string :control_function

      t.timestamps
    end
  end
end
