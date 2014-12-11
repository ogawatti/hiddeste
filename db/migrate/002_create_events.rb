class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :name,         null: false
      t.integer :organizer_id, null: false
      t.string  :place
      t.text    :description
      t.string  :date

      t.timestamps
    end
  end
end
