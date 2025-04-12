class CreateDisplays < ActiveRecord::Migration[7.0]
  def change
    create_table :displays do |t|
      t.references :element, null: false, foreign_key: true
      t.string :display_type
      t.integer :value

      t.timestamps
    end
  end
end
