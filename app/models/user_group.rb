class UserGroup < ActiveRecord::Base
  has_many :user_group_memberships
  has_many :project_memberships
  has_many :users,    :through => :user_group_memberships
  has_many :projects, :through => :project_memberships
end