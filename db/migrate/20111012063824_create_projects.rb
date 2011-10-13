class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.string :prefix
      t.string :title
      t.text   :description

      t.timestamps
    end

    create_table :project_memberships do |t|
      t.belongs_to :project
      t.belongs_to :user
    end

    change_table :tickets do |t|
      t.belongs_to :project
    end

    add_index :projects, :prefix
  end

  def down
    change_table :tickets do |t|
      t.remove_belongs_to :project
    end

    drop_table :project_memberships

    drop_table :projects
  end
end