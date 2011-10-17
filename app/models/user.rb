class User < ActiveRecord::Base
  include Clearance::User

  has_many   :user_group_memberships
  has_many   :user_groups, :through => :user_group_memberships
  has_many   :comments

  validates_uniqueness_of :login, :allow_blank => true

  class << self
    def authenticate(login, password)
      return nil  unless user = (find_by_login(login.to_s) || find_by_email(login.to_s.downcase))
      return user if     user.authenticated?(password)
    end
  end

  def as_json(options={})
    super :only => [:id, :login, :email, :name, :created_at]
  end
end