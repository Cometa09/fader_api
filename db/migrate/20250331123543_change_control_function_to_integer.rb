class ChangeControlFunctionToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :elements, :control_function, :integer, using: 'control_function::integer'
  end
end