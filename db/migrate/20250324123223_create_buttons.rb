class CreateButtons < ActiveRecord::Migration[7.0]
  def change
    create_table :buttons do |t|
      t.references :element, null: false, foreign_key: true
      t.string :image_path
      t.string :status, default: 'inactive'  # По умолчанию "inactive" (или любое другое значение, которое вам нужно)

      t.timestamps
    end
  end
end
