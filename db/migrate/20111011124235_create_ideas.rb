class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.text :notes
      t.timestamps
    end
  end
end