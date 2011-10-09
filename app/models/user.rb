class User < ActiveRecord::Base
  include Clearance::User

  has_many :user_group_memberships
  has_many :user_groups, :through => :user_group_memberships

  validates_presence_of   :login, :unless => "email.present?"
  validates_uniqueness_of :login, :allow_blank => true

  class << self
    def authenticate(login, password)
      return nil  unless user = (find_by_login(login.to_s) || find_by_email(login.to_s.downcase))
      return user if     user.authenticated?(password)
    end
  end

  protected

  # override
  def email_optional?
    login.present?
  end
end
