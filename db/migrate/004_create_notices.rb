class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.integer :event_id, null: false

      t.timestamps
    end
  end
end
