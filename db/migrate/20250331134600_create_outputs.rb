class CreateOutputs < ActiveRecord::Migration[7.0]
  def change
    create_table :outputs do |t|
      t.string :label

      t.timestamps
    end
  end
end
