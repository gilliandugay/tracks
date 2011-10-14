class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket, :touch => true

  validates_length_of   :body, :minimum => 10
  validates_presence_of :body, :user, :ticket

  delegate :name, :login, :email, :to => :user, :prefix => 'author'
end