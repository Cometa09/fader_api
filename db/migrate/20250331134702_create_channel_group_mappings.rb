class CreateChannelGroupMappings < ActiveRecord::Migration[7.0]
  def change
    create_table :channel_group_mappings do |t|
      t.references :channel, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
