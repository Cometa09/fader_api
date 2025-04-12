class CreatePresetSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :preset_settings do |t|
      t.references :preset, null: false, foreign_key: true
      t.references :element, null: false, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
