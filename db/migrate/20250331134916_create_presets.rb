class CreatePresets < ActiveRecord::Migration[7.0]
  def change
    create_table :presets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
