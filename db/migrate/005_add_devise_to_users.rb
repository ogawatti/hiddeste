class AddDeviseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid,          :string
    add_column :users, :name,         :string
    add_column :users, :provider,     :string
    add_column :users, :link,         :string
    add_column :users, :access_token, :string
    add_column :users, :version,      :string

    change_column :users, :uid,          :string, null: false
    change_column :users, :name,         :string, null: false
    change_column :users, :provider,     :string, null: false
    change_column :users, :link,         :string, null: false
    change_column :users, :access_token, :string, null: false
    change_column :users, :version,      :string, null: false
  end
end
