class AddConfigurationToConfigurationElements < ActiveRecord::Migration[7.0]
  def change
    add_column :configuration_elements, :configuration_id, :integer
    add_foreign_key :configuration_elements, :configurations, column: :configuration_id, on_delete: :nullify
  end
end
