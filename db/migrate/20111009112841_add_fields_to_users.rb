class AddFieldsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :login
      t.string :name
    end

    add_index :users, :login
  end
end