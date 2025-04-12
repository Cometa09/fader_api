class AddTargetTypeAddTargetIdAndStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :elements, :target_type, :string, null: false # Полиморфный тип
    add_column :elements, :target_id, :integer, index: true # Полиморфный ID
    add_column :elements, :status, :string
  
    add_index :elements, [:target_type, :target_id]

    reversible do |dir|
      dir.up do
        execute "UPDATE elements SET target_type = 'Channel' WHERE target_type IS NULL"
        change_column_null :elements, :target_type, false # Теперь запрещаем NULL
      end
    end
  end
end
