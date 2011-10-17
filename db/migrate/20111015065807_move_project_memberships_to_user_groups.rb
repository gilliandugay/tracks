class MoveProjectMembershipsToUserGroups < ActiveRecord::Migration
  def up
    drop_table :project_memberships

    create_table :project_memberships do |t|
      t.belongs_to :project
      t.belongs_to :user_group
    end
  end

  def down
    drop_table :project_memberships

    create_table :project_memberships do |t|
      t.belongs_to :project
      t.belongs_to :user
    end
  end
end