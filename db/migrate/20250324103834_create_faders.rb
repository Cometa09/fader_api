class CreateFaders < ActiveRecord::Migration[7.0]
  def change
    create_table :faders do |t|
      t.integer :value

      t.timestamps
    end
  end
end
