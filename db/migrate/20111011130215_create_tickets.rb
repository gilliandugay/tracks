class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string  :code
      t.string  :title
      t.string  :description
      t.integer :priority
      t.integer :time_estimate

      t.timestamps
    end

    create_table :ticket_relations do |t|
      t.references :ticket
      t.references :related_ticket
    end

    add_index :tickets, :code
    add_index :tickets, :priority
  end
end