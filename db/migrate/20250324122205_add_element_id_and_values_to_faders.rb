class AddElementIdAndValuesToFaders < ActiveRecord::Migration[7.0]
  def change
    add_column :faders, :element_id, :integer
    add_column :faders, :min_value, :integer
    add_column :faders, :max_value, :integer
    add_column :faders, :default_value, :integer
  end
end
