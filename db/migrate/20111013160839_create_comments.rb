class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text       :body
      t.belongs_to :ticket
      t.belongs_to :user

      t.timestamps
    end
  end
end