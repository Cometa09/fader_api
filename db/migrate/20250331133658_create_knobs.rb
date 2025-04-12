class CreateKnobs < ActiveRecord::Migration[7.0]
  def change
    create_table :knobs do |t|
      t.references :element, null: false, foreign_key: true
      t.integer :default_value
      t.integer :value
      t.integer :min_value
      t.integer :max_value

      t.timestamps
    end
  end
end
